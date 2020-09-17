# This cmakelist treats CUDA as a first class language, which is supported after cmake 3.8
# Great help from:
# https://cliutils.gitlab.io/modern-cmake/chapters/packages/CUDA.html
# We use the enable_language feature for CUDA in more recent Cmake releases
cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

# Set the NVCC bin dir to Path, or explicitly set here
set (CMAKE_CUDA_COMPILER clang++)
set (CMAKE_CXX_COMPILER clang++)
set (CMAKE_C_COMPILER clang)

enable_language(CUDA)

# Optional
include(CheckLanguage)
# check_language(CUDA)

set (PROJECT_NAME example)

project(${PROJECT_NAME} CUDA CXX)
set (${PROJECT_NAME}_VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# message(${CMAKE_CUDA_FLAGS}) # for debugging
# Add the base directory to your include file search path
include_directories(${CMAKE_SRC_DIR})
set(CMAKE_CUDA_FLAGS "--no-cuda-version-check")
set(SRC_LIST
  # a list of your cpp/cu/header files, e.g. file1.cpp kernel1.cu header.h
  src/example.cpp
  src/cuda/my_kernel.cu
)

#if it is a shared library: (if static, change SHARED to STATIC)
#cuda_add_library(your_project_name SHARED ${SRC_LIST})
# or if it is an executable
add_executable(${PROJECT_NAME} ${SRC_LIST})
# CUDA_SEPARABLE_COMPILATION ON)
set_property(TARGET ${PROJECT_NAME} PROPERTY CUDA_ARCHITECTURES 70)

