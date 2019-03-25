---
post_url: Java-Socket
title: Java 使用 Socket 判断某服务能否连通
date: 2018-08-09 17:57:30
tags: [java, socket]
---
如下只是通过判断端口通不通来大体了解服务的状态，并不能用这个准确判断某服务的实际运行状态。
```java
package com.iaiot.utils;
 
import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;
 
/**
 * SocketUtils
 *
 * @author iaiot
 */
public class SocketUtils {
 
    /**
     * 判断某服务能否连通
     *
     * @param host host
     * @param port port
     * @return boolean
     */
    public static boolean isRunning(String host, int port) {
        Socket sClient = null;
        try {
            SocketAddress saAdd = new InetSocketAddress(host.trim(), port);
            sClient = new Socket();
            sClient.connect(saAdd, 1000);
        }
        catch (UnknownHostException e) {
            return false;
        }
        catch (SocketTimeoutException e) {
            return false;
        }
        catch (IOException e) {
            return false;
        }
        catch (Exception e) {
            return false;
        }
        finally {
            try {
                if (sClient != null) {
                    sClient.close();
                }
            }
            catch (Exception e) {
            }
        }
        return true;
    }
 
}
```