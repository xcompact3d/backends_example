module m_memblock

  type, abstract :: memblock
   contains
     procedure(proc) :: get
  end type memblock

  type, extends(memblock) :: cpublock
     real, allocatable :: content(:)
  end type cpublock

  type, extends(memblock) :: gpublock
     real, allocatable, device :: content(:)
  end type gpublock

  interface cpublock
     module procedure constructor
  end interface cpublock

  interface gpublock
     module procedure constructor
  end interface gpublock

contains

  function constructor(n)
    integer, intent(in) :: n
    type(cpublock) :: cpu_constructor

    allocate(cpu_constructor%content(n))
  end function constructor
end module m_memblock

