module m_gpu
  use m_base, only: basetype

  type, extends(basetype) :: gputype
     real, device :: a_d(:)
   contains
     procedure :: f => f_gpu
     procedure :: g => g_gpu
  end type gputype

contains

  real function f_gpu(self, a)
    class(gputype) :: self
    class(memblock) :: a

    real, device :: buf

    sum_kernel<<<dim3(1,1,1),dim3(16,1,1)>>>(a%data, buf)
    f_gpu = buf
  end function f_gpu

  attributes(global) subroutine sum_kernel(data, buf)
    real, device :: data(:)
    real, device :: buf
    integer :: i, err

    i = threadidx%x
    err = atomic_add(buf, data(i))
  end subroutine sum_kernel
end module m_gpu
