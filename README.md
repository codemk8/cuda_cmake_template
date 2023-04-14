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

Build with clang and Ninja:
```
cmake .. -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CUDA_COMPILER=clang++ -GNinja
ninja
```


## Reference

* <http://on-demand.gputechconf.com/gtc/2017/presentation/S7438-robert-maynard-build-systems-combining-cuda-and-machine-learning.pdf>
* <https://cliutils.gitlab.io/modern-cmake/chapters/packages/CUDA.html>
