# This cmakelist treats CUDA as a first class language, which is supported after cmake 3.8
# Great help from:
# https://cliutils.gitlab.io/modern-cmake/chapters/packages/CUDA.html
# We use the enable_language feature for CUDA in more recent Cmake releases
cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

# Set the NVCC bin dir to Path, or explicitly set here
set (CMAKE_CUDA_COMPILER /usr/local/cuda/bin/nvcc)

enable_language(CUDA)

# Optional
include(CheckLanguage)
check_language(CUDA)

set (PROJECT_NAME example)

project(${PROJECT_NAME} CUDA CXX)
set (${PROJECT_NAME}_VERSION 0.1.0)

if(NOT DEFINED CMAKE_CUDA_STANDARD)
    set(CMAKE_CUDA_STANDARD 11)
    set(CMAKE_CUDA_STANDARD_REQUIRED ON)
endif()

# CUDA architecture options, choose what you want
set(GENCODE_SM60 "-gencode=arch=compute_60,code=sm_60")
set(GENCODE_SM62 "-gencode=arch=compute_62,code=sm_62")

#CUDA_SELECT_NVCC_ARCH_FLAGS(ARCH_FLAGS 3.0 3.5+PTX 5.2(5.0) Maxwell)
LIST(APPEND CUDA_NVCC_FLAGS ${GENCODE_SM60}, ${GENCODE_SM62})

message(${CUDA_NVCC_FLAGS})
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
add_executable(${PROJECT_NAME} ${SRC_LIST})
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)
set_target_properties(${PROJECT_NAME} PROPERTIES
  CUDA_SEPARABLE_COMPILATION ON)

if(APPLE)
  # We need to add the path to the driver (libcuda.dylib) as an rpath, 
  # so that the static cuda runtime can find it at runtime.
  set_property(TARGET ${PROJECT_NAME}
               PROPERTY
               BUILD_RPATH ${CMAKE_CUDA_IMPLICIT_LINK_DIRECTORIES})
 endif()
