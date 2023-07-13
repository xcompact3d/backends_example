cmake_minimum_required(VERSION 3.16)
project(test_backends LANGUAGES Fortran)

set(SRC
  memblock.f90
  base.f90
  cpu/memblock_cpu.f90
  cpu/cpu.f90
)

set(CUDASRC
  gpu/memblock_gpu.f90
  gpu/gpu.f90
)

add_executable(main_cpu ${SRC} main_cpu.f90)

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL "PGI")
  list(APPEND SRC ${CUDASRC})

  add_executable(main_gpu ${SRC} main_gpu.f90)
  add_executable(main_hybrid ${SRC} main_hybrid.f90)

  target_compile_options(main_gpu PRIVATE "-cuda")
  target_link_options(main_gpu PRIVATE "-cuda")

  target_compile_options(main_hybrid PRIVATE "-cuda")
  target_link_options(main_hybrid PRIVATE "-cuda")
endif()
