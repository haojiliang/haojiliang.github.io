---
title: ssl 证书访问 docker 远程 api
post_url: docker_cert
date: 2019-04-24 10:21:59
tags: [docker]
---

# 生成证书
openssl genrsa -aes256 -out ca-key.pem 4096  
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem  

openssl genrsa -out server-key.pem 4096  
openssl req -subj "/CN=docker-server" -sha256 -new -key server-key.pem -out server.csr  

echo subjectAltName = DNS:docker-server,IP:127.0.0.1 >> extfile.cnf  
echo extendedKeyUsage = serverAuth >> extfile.cnf  
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile extfile.cnf  

openssl genrsa -out key.pem 4096  
openssl req -subj '/CN=client' -new -key key.pem -out client.csr  

echo extendedKeyUsage = clientAuth > extfile-client.cnf  
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile-client.cnf  

rm -v client.csr server.csr extfile.cnf extfile-client.cnf  
参考：https://docs.docker.com/engine/security/https/

其中 docker-server 为访问 docker api 用的域名   
配置host：192.168.153.7 docker-server   
这个docker-server就相当于ssl证书的域名，这个证书是这个域名用的，换用其他域名连接会报证书验证失败

# docker 配置
配置 /etc/docker/daemon.json，没有则新建
```json
{
  "tlsverify": true,
  "tlscert": "/root/cert/server-cert.pem",
  "tlskey": "/root/cert/server-key.pem",
  "tlscacert": "/root/cert/ca.pem",
  "hosts": [
    "tcp://0.0.0.0:2376",
    "unix:///var/run/docker.sock"
  ]
}
```

# Java 连接 docker
```java
public static DockerClient getDockerClient() {
        DockerClientConfig config = DefaultDockerClientConfig.createDefaultConfigBuilder()
                .withDockerHost("tcp://docker-server:2376")
                .withDockerTlsVerify(true)
                .withDockerCertPath("/root/youCertPath")
                .build();

        DockerCmdExecFactory dockerCmdExecFactory = new JerseyDockerCmdExecFactory()
                .withReadTimeout(1000)
                .withConnectTimeout(1000)
                .withMaxTotalConnections(100)
                .withMaxPerRouteConnections(10);

        DockerClient dockerClient = DockerClientBuilder.getInstance(config)
                .withDockerCmdExecFactory(dockerCmdExecFactory)
                .build();

        return dockerClient;
    }
```