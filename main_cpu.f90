program main_cpu
  use m_base, only: basetype
  use m_cpu, only: cputype
  use m_memblock_cpu, only: cpublock

  class(basetype), allocatable :: obj
  type(cpublock) :: blk

  blk = cpublock(16)

  allocate(cputype :: obj)
  obj = cputype() ! This should automatically trigger
  ! allocation of obj. It does for gfortran (9.4), but not for
  ! nvfortran (22.5), which segfaults. Therefore obj is manually
  ! allocated. This might be a problem since allocation must know
  ! the dynamic type of obj.

  write(*,*) obj%doit(blk)
end program main_cpu
