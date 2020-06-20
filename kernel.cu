#include <iostream>
#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <memory>

#define N 5


/*
该代码演示了如何从设备代码中进行全局内存的写入，以及如何从主机代码中用cudaMalloc进行分配，如何将指向
该段全局内存的指针作为内核函数。内核函数用不同的线程ID的值填充这段全局内存。然后（用cudaMemcpy）复制到内存以便
显示内容。由于使用的是全局内存，这个操作将会很慢。
*/
__global__ void gpu_global_memory(int* d_a) {
	d_a[threadIdx.x] = threadIdx.x;
}

int main(void) {
	int h_a[N];
	int* d_a;
	cudaMalloc((void**)&d_a, sizeof(int) * N);
	cudaMemcpy((void*)d_a, (void*)h_a, sizeof(int) * N, cudaMemcpyHostToDevice);
	gpu_global_memory << <1, N >> > (d_a);
	cudaMemcpy((void*)h_a, (void*)d_a, sizeof(int) * N, cudaMemcpyDeviceToHost);
	printf("Array in Global Memory is:\n");
	for (int i = 0; i < N; i++)
	{
		printf("At Index:%d -->%d\n", i, h_a[i]);
	}
	return 0;
}