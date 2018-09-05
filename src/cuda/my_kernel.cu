#include <iostream>
#include "my_kernel.h"

using namespace std;
constexpr int con = 3; // C++11 feature

__global__ void my_kernel() {
  printf("inside my kernel con is %d\n", con);
  // call the real kernel <<< >>>
}

void my_kernel_wrapper() {
  my_kernel<<<1, 1>>>();
}
