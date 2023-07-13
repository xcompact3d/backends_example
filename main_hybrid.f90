program main_hybrid
  use m_base, only: basetype
  use m_memblock, only: memblock
  use m_cpu, only: cputype
  use m_memblock_cpu, only: cpublock
  use m_gpu, only: gputype
  use m_memblock_gpu, only: gpublock

  class(basetype), allocatable :: obj

  class(memblock), pointer :: blk
  type(cpublock), target :: cpublk
  type(gpublock), target :: gpublk

  select case(get_target_from_cli())
  case('cpu')

     cpublk = cpublock(16); blk => cpublk

     allocate(cputype :: obj)
     obj = cputype() ! This should automatically trigger
     ! allocation of obj. It does for gfortran (9.4), but not for
     ! nvfortran (22.5), which segfaults. Therefore obj is manually
     ! allocated. This might be a problem since allocation must know
     ! the dynamic type of obj.

     write(*,*) "Executing CPU code only."
  case('gpu')

     gpublk = gpublock(16); blk => gpublk


     allocate(gputype :: obj)
     obj = gputype()

     write(*,*) "Executing CUDA kernels."

  case default
     write(*,*) "main: unknown execution target"
     error stop
  end select


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
