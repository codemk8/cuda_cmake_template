# cuda_cmake_boilerplate

boilerplate to start a CUDA cmake project

# Walkthrough

```bash
git clone https://github.com/codemk8/cuda_cmake_boilerplate.git

cd cuda_cmake_boilerplate

# create a build dir for cmake
mkdir build

cd build

cmake ..
# or cmake .. -DCMAKE_BUILD_TYPE=Release/Debug for debug/release build

make -j 4

```
