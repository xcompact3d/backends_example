module m_memblock_gpu
  use m_memblock, only: memblock

  type, extends(memblock) :: gpublock
     real, allocatable, device :: content(:)
  end type gpublock

    interface gpublock
     module procedure constructor
  end interface gpublock

  contains

  function constructor(n)
    integer, intent(in) :: n
    type(gpublock) :: constructor

    allocate(constructor%content(n))
    constructor%content = [(i, i=1,n)]
  end function constructor
end module m_memblock_gpu
