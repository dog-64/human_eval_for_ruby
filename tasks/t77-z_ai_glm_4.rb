
def is_cube?(a)
  return true if a == 0

  abs_a = a.abs

  high = 1
  while high ** 3 < abs_a
    high *= 2
  end

  low = high / 2

  while low <= high
    mid = (low + high) / 2
    mid_cubed = mid * mid * mid

    if mid_cubed == abs_a
      return true
    elsif mid_cubed < abs_a
      low = mid + 1
    else
      high = mid - 1
    end
  end

  false
end