program main
  use m_base, only: basetype
  use m_getit, only: getit

  class(basetype), allocatable :: obj
  real :: a(8)

  a = [1, 2, 3, 4, 5, 6, 7, 8]
  obj = getit()

  write(*,*) obj%doit(a)
end program main
