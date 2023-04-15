// #undef __SIZEOF_FLOAT128__
#include <iostream>
#include <system_error>

#include <rmm/mr/device/cuda_memory_resource.hpp>
#include <rmm/mr/device/device_memory_resource.hpp>
#include <rmm/mr/device/pool_memory_resource.hpp>
#include <rmm/mr/device/per_device_resource.hpp>
#include <rmm/device_uvector.hpp>
#include <thrust/uninitialized_fill.h>
#include <thrust/system/cuda/execution_policy.h>

#include "my_kernel.h"

using namespace std;
constexpr int con = 3;

__global__ void my_kernel() {
  printf("inside my kernel con is %d\n", con);
  // call the real kernel <<< >>>
}

void my_kernel_wrapper() {
  printf("calling kernel\n");
  my_kernel<<<1, 1>>>();
}


cudaError_t example() {
  rmm::mr::cuda_memory_resource cuda_mr;
  // Construct a resource that uses a coalescing best-fit pool allocator
  rmm::mr::pool_memory_resource<rmm::mr::cuda_memory_resource> pool_mr{&cuda_mr};
  rmm::mr::set_current_device_resource(&pool_mr); // Updates the current device resource pointer to `pool_mr`
  rmm::mr::device_memory_resource * mr = rmm::mr::get_current_device_resource(); 
  rmm::cuda_stream_view s{};
 
  // Allocates *uninitialized* device memory on stream `s` sufficient for 100 ints using the
  // supplied resource `mr`
  rmm::device_uvector<int> uv(100, s, mr);
  // std::cout << uv.begin() << ":" << uv.end() << std::endl;
  thrust::uninitialized_fill(thrust::cuda::par.on(s.value()), uv.begin(), uv.end(), 0);
  return cudaDeviceSynchronize();  							     
}