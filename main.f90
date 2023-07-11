program main
  use m_base, only: basetype
  use m_cpu, only: cputype
  use m_memblock_cpu, only: cpublock

  class(basetype), allocatable :: obj
  type(cpublock) :: blk

  blk = cpublock(16)
  obj = cputype()

  write(*,*) obj%doit(blk)
end program main
