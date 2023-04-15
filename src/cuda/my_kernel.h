#pragma once
#include <cuda_runtime_api.h>
void my_kernel_wrapper();

class InCUDA {
private:
  int a{0}; // C++11 feature
};


cudaError_t example();
