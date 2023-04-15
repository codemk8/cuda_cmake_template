cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

# Optional
include(CheckLanguage)
check_language(CUDA)

set (PROJECT_NAME example)
set (VERSION "1.0")
set(CMAKE_CUDA_ARCHITECTURES "35;60")
project(${PROJECT_NAME} LANGUAGES CXX CUDA)


set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED True)

# mkdir -p cmake
# wget -O cmake/CPM.cmake https://github.com/TheLartians/CPM.cmake/releases/latest/download/CPM.cmake
include(cmake/CPM.cmake)
CPMAddPackage("gh:rapidsai/rmm@23.04.00")

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

target_link_libraries(${PROJECT_NAME} PRIVATE rmm)
# hack to build fmt lib in clang 
target_compile_options(${PROJECT_NAME} PRIVATE -U__SIZEOF_FLOAT128__)

set_target_properties(${PROJECT_NAME} PROPERTIES CUDA_ARCHITECTURES "35;60")
target_include_directories(
    ${PROJECT_NAME}
    PRIVATE 
    ${CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES}
)
