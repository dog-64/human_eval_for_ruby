def is_cube?(a)
  low = a < 0 ? a : 0
  high = a > 0 ? a : 0
  while low <= high
    mid = (low + high) / 2
    cube = mid * mid * mid
    return true if cube == a
    if cube < a
      low = mid + 1
    else
      high = mid - 1
    end
  end
  false
end