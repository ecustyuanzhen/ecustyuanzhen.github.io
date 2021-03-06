---
title: 设计模式-责任链模式
date: 2020-10-19 14:27:24
tags:
---

#### 是什么

将多个处理对象串成链，可以让每一个对象都处理请求，也可以在某一个处理完后就结束流程，避免请求发送者与接收者耦合在一起。

#### 类图
![][image-1]
#### 多种形式
* 客户端通过list  将handler串起来。
* handler 通过next指针指定下一个handler
* 每个Handler都有机会处理Request，通常这种责任链被称为拦截器（Interceptor）或者过滤器（Filter）
#### 缺点
* 一个请求可能因职责链没有被正确配置而得不到处理
* 对于比较长的职责链，请求的处理可能涉及到多个处理对象，系统性能将受到一定影响，且不方便调试
* 可能因为职责链创建不当，造成循环调用，导致系统陷入死循环

[image-1]:	https://user-gold-cdn.xitu.io/2018/10/31/166c90b265849954?imageslim