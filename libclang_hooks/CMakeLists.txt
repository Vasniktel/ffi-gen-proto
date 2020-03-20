cmake_minimum_required(VERSION 3.10)

project(libclang_hooks C)

set(CMAKE_C_STANDARD 99)
set(LIBCLANG_DIR "/usr/lib/llvm-6.0")
set(LIBCLANG_LINK_DIR "${LIBCLANG_DIR}/lib")
set(LIBCLANG_INCLUDE_DIR "${LIBCLANG_DIR}/include")

link_directories(${LIBCLANG_LINK_DIR})
add_library(clang_hooks SHARED
    libclang_hooks.c
    libclang_hooks.h)

target_include_directories(clang_hooks PUBLIC ${LIBCLANG_INCLUDE_DIR})
target_link_libraries(clang_hooks clang)
