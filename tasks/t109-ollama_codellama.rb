def move_one_ball(arr)
  return true if arr.empty?

  sorted = arr.sort
  cycled = arr.cycle

  while sorted != cycled
    sorted = sorted.rotate(1)
    cycled = cycled.cycle
  end

  return false unless sorted == arr
end