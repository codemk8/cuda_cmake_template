#include <iostream>
#include "cuda/my_kernel.h"
using namespace std;

class A {
private:
  int a{0};
};

int main()
{
  std::cout << "Hello world!" << std::endl;
  my_kernel_wrapper();

  return example();
}
