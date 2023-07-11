set(SRC
  memblock.f90
  base.f90
  cpu/memblock_cpu.f90
  cpu/cpu.f90
  main.f90
)

set(CUDASRC
  cuda/memblock_gpu.f90
  cuda/gpu.f90
)

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL "PGI")
  list(APPEND SRC ${CUDASRC})
endif()

add_executable(main ${SRC})

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL "PGI")
  target_compile_options(main PRIVATE "-cuda")
endif()
