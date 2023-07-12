module m_memblock_cpu
  use m_memblock, only: memblock

  type, extends(memblock) :: cpublock
     real, allocatable :: content(:)
  end type cpublock

    interface cpublock
     module procedure constructor
  end interface cpublock

  contains

  function constructor(n)
    integer, intent(in) :: n
    type(cpublock) :: constructor

    allocate(constructor%content(n))
    constructor%content = [(i, i=1,n)]
  end function constructor
end module m_memblock_cpu
