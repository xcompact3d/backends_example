program main_gpu
  use m_gpu, only: gputype
  use m_memblock_gpu, only: gpublock

  type(gputype) :: obj
  type(gpublock) :: blk

  blk = gpublock(16)

  obj = gputype()

  write(*,*) obj%doit(blk)
end program main_gpu
