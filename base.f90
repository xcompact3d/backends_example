module m_base
  use m_memblock, only: memblock
  type, abstract :: basetype
   contains
     procedure(proc), deferred :: f, g
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
    class(basetype) :: self
    class(memblock) :: blk

    doit = self%f(blk) + self%g(blk)
  end function doit
end module m_base
