module m_gpu
  use cudafor
  use m_base, only: basetype
  use m_memblock, only: memblock
  use m_memblock_gpu, only: gpublock

  type, extends(basetype) :: gputype
   contains
     procedure :: f => f_gpu
     procedure :: g => g_gpu
  end type gputype

contains

  real function f_gpu(self, a)
    class(gputype) :: self
    class(memblock) :: a

    real, allocatable :: b(:)
    real, device, allocatable :: b_d(:)

    select type (a)
    type is (gpublock)
       allocate(b_d(size(a%content)))
       call f_kernel<<<dim3(1,1,1),dim3(16,1,1)>>>(a%content, b_d)
    class default
       error stop
    end select

    ! Transfer back device array to host in order to
    ! reduce it to a scalar for the sake of this example.
    b = b_d
    f_gpu = sum(b)
  end function f_gpu

  attributes(global) subroutine f_kernel(in, out)
    real, device, intent(in) :: in(:)
    real, device, intent(out) :: out(:)
    integer :: i

    i = threadidx%x
    out(i) = in(i) + 1
  end subroutine f_kernel

  real function g_gpu(self, a)
    class(gputype) :: self
    class(memblock) :: a

    !! TODO
    g_gpu = 2.
  end function g_gpu
end module m_gpu
