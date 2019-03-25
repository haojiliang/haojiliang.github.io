---
post_url: app-api-token
title: App开放接口api安全性—Token签名sign的设计与实现
date: 2018-08-14 18:58:00
tags: 项目
---
原文地址：https://blog.csdn.net/fengshizty/article/details/48754609
前言
       在app开放接口api的设计中，避免不了的就是安全性问题，因为大多数接口涉及到用户的个人信息以及一些敏感的数据，所以对这些接口需要进行身份的认证，那么这就需要用户提供一些信息，比如用户名密码等，但是为了安全起见让用户暴露的明文密码次数越少越好，我们一般在web项目中，大多数采用保存的session中，然后在存一份到cookie中，来保持用户的回话有效性。但是在app提供的开放接口中，后端服务器在用户登录后如何去验证和维护用户的登陆有效性呢，以下是参考项目中设计的解决方案，其原理和大多数开放接口安全验证一样，如淘宝的开放接口token验证，微信开发平台token验证都是同理。

 

签名设计
     对于敏感的api接口，需使用https协议
           https是在http超文本传输协议加入SSL层，它在网络间通信是加密的，所以需要加密证书。

           https协议需要ca证书，一般需要交费。

 

     签名的设计
           原理：用户登录后向服务器提供用户认证信息（如账户和密码），服务器认证完后给客户端返回一个Token令牌，用户再次获取信息时，带上此令牌，如果令牌正取，则返回数据。对于获取Token信息后，访问用户相关接口，客户端请求的url需要带上如下参数：

         时间戳：timestamp

         Token令牌：token

         然后将所有用户请求的参数按照字母排序（包括timestamp，token），然后更具MD5加密（可以加点盐），全部大写，生成sign签名，这就是所说的url签名算法。然后登陆后每次调用用户信息时，带上sign，timestamp，token参数。

例如：原请求https://www.andy.cn/api/user/update/info.shtml?city=北京 （post和get都一样，对所有参数排序加密）

 加上时间戳和token

       https://www.andy.cn/api/user/update/info.shtml?city=北京×tamp=12445323134&token=wefkfjdskfjewfjkjfdfnc

      然后更具url参数生成sign

      最终的请求如

         https://www.andy.cn/api/user/update/info.shtml?city=北京×tamp=12445323134&token=wefkfjdskfjewfjkjfdfnc&sign=FDK2434JKJFD334FDF2

 

其最终的原理是减小明文的暴露次数；保证数据安全的访问。

具体实现如下：

           1. api请求客户端想服务器端一次发送用用户认证信息（用户名和密码），服务器端请求到改请求后，验证用户信息是否正确。

        如果正确：则返回一个唯一不重复的字符串（一般为UUID），然后在Redis（任意缓存服务器）中维护Token----Uid的用户信息关系，以便其他api对token的校验。

        如果错误：则返回错误码。

          

            2.服务器设计一个url请求拦截规则

               （1）判断是否包含timestamp，token，sign参数，如果不含有返回错误码。

               （2）判断服务器接到请求的时间和参数中的时间戳是否相差很长一段时间（时间自定义如半个小时），如果超过则说明该                         url已经过期（如果url被盗，他改变了时间戳，但是会导致sign签名不相等）。

               （3）判断token是否有效，根据请求过来的token，查询redis缓存中的uid，如果获取不到这说明该token已过期。

               （4）根据用户请求的url参数，服务器端按照同样的规则生成sign签名，对比签名看是否相等，相等则放行。（自然url签名                       也无法100%保证其安全，也可以通过公钥AES对数据和url加密，但这样如果无法确保公钥丢失，所以签名只是很大程                       度上保证安全）。

                （5）此url拦截只需对获取身份认证的url放行（如登陆url），剩余所有的url都需拦截。

 

            3.Token和Uid关系维护

               对于用户登录我们需要创建token--uid的关系，用户退出时需要需删除token--uid的关系。