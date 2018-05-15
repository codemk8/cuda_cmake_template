cmake_minimum_required(VERSION 2.8)

set (PROJECT_NAME example)
project(${PROJECT_NAME})
set (${PROJECT_NAME}_VERSION 0.1.0)
find_package(CUDA REQUIRED)

# CUDA architecture options, choose what you want
set(GENCODE_SM60 "-gencode=arch=compute_60,code=sm_60")
set(GENCODE_SM62 "-gencode=arch=compute_62,code=sm_62")

set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS} ${GENCODE_SM60} ${GENCODE_SM62})

# Add the base directory to your include file search path
include_directories(${CMAKE_SRC_DIR})

set(SRC_LIST
  # a list of your cpp/cu/header files, e.g. file1.cpp kernel1.cu header.h
  src/example.cpp
  src/cuda/my_kernel.cu
)

#if it is a shared library: (if static, change SHARED to STATIC)
#cuda_add_library(your_project_name SHARED ${SRC_LIST})
# or if it is an executable
cuda_add_executable(${PROJECT_NAME} ${SRC_LIST})