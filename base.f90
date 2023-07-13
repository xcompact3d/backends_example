module m_base
  use m_memblock, only: memblock
  type, abstract :: basetype
   contains
     procedure(proc), deferred :: f
     procedure(proc), deferred :: g
     procedure :: doit
  end type basetype

  abstract interface
     real function proc(self, a)
       import :: basetype
       import :: memblock
       class(basetype) :: self
       class(memblock) :: a
     end function proc
  end interface

contains

  real function doit(self, blk)
    !! Template method
    class(basetype) :: self
    class(memblock) :: blk

    real :: a, b

    ! Both f and g are defined in types
    ! extending basetype.
    a = self%f(blk)
    b = self%g(blk)

    doit = a + b
  end function doit
end module m_base
