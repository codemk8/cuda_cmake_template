#include <iostream>
#include <chrono>
#include <thread>
#include "cuda/my_kernel.h"

using namespace std;

class A {
private:
  int a{0}; // C++11 feature
};

int main()
{
  std::cout << "Hello world!" << std::endl;
  my_kernel_wrapper();
  std::this_thread::sleep_for(std::chrono::milliseconds(1000));
  return 0;
}
