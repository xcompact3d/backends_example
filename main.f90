program main_hybrid
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

contains

  character(3) function get_target_from_cli() result(tgt)
    integer :: length, status
    character(100) :: arg

    call get_command_argument(1, arg, length, status)
    if (status > 0) then
       tgt = 'cpu'
       return
    end if
    if (arg /= '--gpu') then
       write(*,*) "ERROR: Unknown option", arg
       error stop
    end if
    tgt = 'gpu'
  end function get_target_from_cli

end program main_hybrid
