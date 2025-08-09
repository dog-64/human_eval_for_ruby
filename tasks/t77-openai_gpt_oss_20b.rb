def is_cube?(a)
  return true if a == 0
  abs_a = a.abs
  low = 0
  high = abs_a
  while low <= high
    mid = (low + high) / 2
    cube = mid * mid * mid
    if cube == abs_a
      return true
    elsif cube < abs_a
      low = mid + 1
    else
      high = mid - 1
    end
  end
  false
end