---
title: ThradPoolExecutor
date: 2021-02-10 11:09:49
tags:
---

#### 类图

![图1 ThreadPoolExecutor UML类图](https://p1.meituan.net/travelcube/912883e51327e0c7a9d753d11896326511272.png)

ThreadPoolExecutor实现的顶层接口是**Executor**，顶层接口Executor提供了一种思想：将任务提交和任务执行进行解耦。用户无需关注如何创建线程，如何调度线程来执行任务，用户只需提供Runnable对象，将任务的运行逻辑提交到执行器(Executor)中，由Executor框架完成线程的调配和任务的执行部分。**ExecutorService**接口增加了一些能力：（1）扩充执行任务的能力，补充可以为一个或一批异步任务生成Future的方法；（2）提供了管控线程池的方法，比如停止线程池的运行。**AbstractExecutorService**则是上层的抽象类，将执行任务的流程串联了起来，保证下层的实现只需关注一个执行任务的方法即可。最下层的实现类**ThreadPoolExecutor**实现最复杂的运行部分，ThreadPoolExecutor将会一方面维护自身的生命周期，另一方面同时管理线程和任务，使两者良好的结合从而执行并行任务。

#### 运行流程图

![图2 ThreadPoolExecutor运行流程](https://p0.meituan.net/travelcube/77441586f6b312a54264e3fcf5eebe2663494.png)

线程池在内部实际上构建了一个生产者消费者模型，将线程和任务两者解耦，并不直接关联，从而良好的缓冲任务，复用线程。线程池的运行主要分成两部分：任务管理、线程管理。任务管理部分充当生产者的角色，当任务提交后，线程池会判断该任务后续的流转：（1）直接申请线程执行该任务；（2）缓冲到队列中等待线程执行；（3）拒绝该任务。线程管理部分是消费者，它们被统一维护在线程池内，根据任务请求进行线程的分配，当线程执行完任务后则会继续获取新的任务去执行，最终当线程获取不到任务的时候，线程就会被回收。

#### 参数

##### coresize

默认情况下，只有任务到来的时候才会创建core thrad，但是可以通过方法， prestartCoreThread or prestartAllCoreThreads 来重写

##### maxsize

当一个新的任务过来后，

- 如果当前线程池的size小于core，那么即使池子里有空闲线程，也会创建新的线程来处理；

- 如果当前线程池的size大于core但是小于max，那么只有队列满了后才会创建新的线程。

**Keep-alive times**

默认情况，当线程池线程数量超过core，那么多余的线程在空闲Keep-alive times 后会被回收，但是 通过方法allowCoreThreadTimeOut(boolean) 

 可以回收core thrad。
**Queuing**

- 如果当前线程数小于core，直接创建线程

- 如果当前线程数小于max，进去queue，

- 如果queue已经满了，此时若线程数量小于max则直接创建，若大于max则reject

通常有三种队列策略：

1. 直接移交

   工作队列的一个很好的默认选择是SynchronousQueue，它可以将任务移交给线程，而不必另外保留它们。适用于并发提高响应速度的场景，但是需要core、maxsize足够大。

2. 无界队列

    例如 LinkedBlockingQueu，此时max的参数不再工作，所有任务进去队列

3. 有界队列

    ArrayBlockingQueue

   

##### Rejected tasks

存在4种拒绝策略

1. 中止（默认）

   抛出异常

2. 调用者运行

3. 抛弃

4. 抛弃最旧的



#### 生命周期

线程池内部使用一个变量维护两个值：**运行状态(**runState)和**线程数量** (workerCount)。在具体实现中，线程池将运行状态(runState)、线程数量 (workerCount)两个关键参数的维护放在了一起。

`ctl`这个AtomicInteger类型，是对线程池的运行状态和线程池中有效线程的数量进行控制的一个字段， 它同时包含两部分的信息：线程池的运行状态 (runState) 和线程池内有效线程的数量 (workerCount)，高3位保存runState，低29位保存workerCount，两个变量之间互不干扰。

```java
private final AtomicInteger ctl = new AtomicInteger(ctlOf(RUNNING, 0));
private static final int COUNT_BITS = Integer.SIZE - 3;
private static final int CAPACITY   = (1 << COUNT_BITS) - 1;

// runState is stored in the high-order bits
private static final int RUNNING    = -1 << COUNT_BITS;
private static final int SHUTDOWN   =  0 << COUNT_BITS;
private static final int STOP       =  1 << COUNT_BITS;
private static final int TIDYING    =  2 << COUNT_BITS;
private static final int TERMINATED =  3 << COUNT_BITS;

// Packing and unpacking ctl
private static int runStateOf(int c)     { return c & ~CAPACITY; }
private static int workerCountOf(int c)  { return c & CAPACITY; }
private static int ctlOf(int rs, int wc) { return rs | wc; }
```

##### 状态

- RUNNING：接受新任务并处理排队任务
- SHUTDOWN：不接受新任务，但处理排队任务
- STOP：不接受新任务、不处理排队任务、中断正在进行的任务
- TIDING：所有任务都已终止、workerCount为0时，线程会切换到TIDING、并运行 terminate() 钩子方法
- TERMINATED：terminate() 运行完成

