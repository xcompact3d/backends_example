module m_cpu
  use m_base, only: basetype
  use m_memblock, only: memblock

  type, extends(basetype) :: cputype
   contains
     procedure :: f => f_cpu
     procedure :: g => g_cpu
  end type cputype

contains

  real function f_cpu(self, a)
    class(cputype) :: self
    class(memblock) :: a

    f_cpu = sum(a%content)
  end function f_cpu

  real function g_cpu(self, a)
    class(cputype) :: self
    class(memblock) :: a

    g_cpu = maxval(a%content)
  end function g_cpu
end module m_cpu
