cmake_minimum_required(VERSION 3.16)
project(test_backends LANGUAGES Fortran)

set(SRC
  memblock.f90
  base.f90
  cpu/memblock_cpu.f90
  cpu/cpu.f90
  main.f90
)

set(CUDASRC
  gpu/memblock_gpu.f90
  gpu/gpu.f90
)

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL "PGI")
  list(APPEND SRC ${CUDASRC})
endif()

add_executable(main ${SRC})

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL "PGI")
  target_compile_options(main PRIVATE "-cuda")
  target_link_options(main PRIVATE "-cuda")
endif()
