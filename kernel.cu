#include <iostream>
#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <memory>

#define N 5


/*
�ô�����ʾ����δ��豸�����н���ȫ���ڴ��д�룬�Լ���δ�������������cudaMalloc���з��䣬��ν�ָ��
�ö�ȫ���ڴ��ָ����Ϊ�ں˺������ں˺����ò�ͬ���߳�ID��ֵ������ȫ���ڴ档Ȼ����cudaMemcpy�����Ƶ��ڴ��Ա�
��ʾ���ݡ�����ʹ�õ���ȫ���ڴ棬����������������
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