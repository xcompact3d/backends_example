module m_cpu
  use m_base, only: basetype
  use m_memblock, only: memblock
  use m_memblock_cpu, only: cpublock

  type, extends(basetype) :: cputype
   contains
     procedure :: f => f_cpu
     procedure :: g => g_cpu
  end type cputype

contains

  real function f_cpu(self, a)
    class(cputype) :: self
    class(memblock) :: a

    select type (a)
    type is (cpublock)
       f_cpu = sum(a%content + 1)
    class default
       error stop
    end select
  end function f_cpu

  real function g_cpu(self, a)
    class(cputype) :: self
    class(memblock) :: a

    select type (a)
    type is (cpublock)
       g_cpu = maxval(a%content * 2)
    class default
       error stop
    end select
  end function g_cpu
end module m_cpu
