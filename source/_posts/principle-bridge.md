---
title: 设计模式-桥接模式
date: 2020-11-15 22:35:06
tags:
---



### 是什么

> 将抽象部分与它的实现部分分离，使它们都可以独立地变化。更容易理解的表述是：实现系统可从多种维度分类，桥接模式将各维度抽象出来，各维度独立变化，之后可通过聚合，将各维度组合起来，减少了各维度间的耦合。

### 解决的问题

在类型存在多维度发展的情况，会出现类爆炸的趋势，**桥接模式**将各个维度设计成独立的继承结构，使各个维度可以独立的扩展在抽象层建立关联。



### 类图

![img](http://www.jasongj.com/img/designpattern/bridge/Bridge.png)
