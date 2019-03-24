---
post_url: java-image-base64
title: java实现image和base64互转
date: 2018-08-09 17:21:45
tags: java
---
原文：https://blog.csdn.net/windon12345/article/details/45966949

java安装的目录下的jre/lib/rt.jar中有以下两个类实现base64的编码和解码：
sun.misc.BASE64Encoder
sun.misc.BASE64Decoder

 

下面是java实现：
```java
public class Imagebase64 {
    static BASE64Encoder encoder = new sun.misc.BASE64Encoder();
    static BASE64Decoder decoder = new sun.misc.BASE64Decoder();

    public static void main(String[] args) {
        System.out.println(getImageBinary()); // image to base64
        base64StringToImage(getImageBinary()); // base64 to image
    }

    static String getImageBinary() {
        File f = new File("d://in.jpg");
        try {
            BufferedImage bi = ImageIO.read(f);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(bi, "jpg", baos);
            byte[] bytes = baos.toByteArray();

            return encoder.encodeBuffer(bytes).trim();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    static void base64StringToImage(String base64String) {
        try {
            byte[] bytes1 = decoder.decodeBuffer(base64String);
            ByteArrayInputStream bais = new ByteArrayInputStream(bytes1);
            BufferedImage bi1 = ImageIO.read(bais);
            File f1 = new File("d://out.jpg");
            ImageIO.write(bi1, "jpg", f1);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```