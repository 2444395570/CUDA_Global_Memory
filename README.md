# CUDA_Global_Memory
cuda全局内存进行读写。
存储器架构：在GPU上的代码执行被划分为流多处理器、块和线程。GPU有几个不同的存储器空间，每个存储器空间都有特定的特征和用途以及不同的速度和范围。这个
存储空间按层次结构划分为不同的组块，比如全局内存、共享内存、本地内存、常量内存和纹理内存，每个组块都可以从程序中的不同点访问。
![GPU架构图](https://github.com/2444395570/CUDA_Global_Memory/blob/master/GPU_1.jpg)![存储器架构图](https://github.com/2444395570/CUDA_Global_Memory/blob/master/GPU_2.jpg)


