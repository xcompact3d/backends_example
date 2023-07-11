module m_getit
  use m_cpu, only: cputype
contains

  type(cputype) function getit()
    getit = cputype(n=3)
  end function getit
  
end module m_getit
