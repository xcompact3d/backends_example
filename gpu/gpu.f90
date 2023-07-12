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

    real, device :: buf

    select type (a)
    type is (gpublock)
       call sum_kernel<<<dim3(1,1,1),dim3(16,1,1)>>>(a%content, buf)
    class default
       error stop
    end select

    f_gpu = buf
  end function f_gpu

  attributes(global) subroutine sum_kernel(data, buf)
    real, device :: data(:)
    real, device :: buf
    integer :: i, err

    i = threadidx%x
    err = atomic_add(buf, data(i))
  end subroutine sum_kernel

  real function g_gpu(self, a)
    class(gputype) :: self
    class(memblock) :: a

    !! TODO
    g_gpu = 2.
  end function g_gpu
end module m_gpu
