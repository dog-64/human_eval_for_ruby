
def is_simple_power?(x, n)
  if x == 0
    return false
  end
  if n == 0
    return false
  end
  if x == 1
    return true
  end
  if n == 1
    return false
  end

  low_exp = 0
  high_exp = 1
  current_high = n

  while current_high < x
    low_exp = high_exp
    high_exp *= 2
    current_high = current_high * current_high
  end

  while low_exp <= high_exp
    mid_exp = (low_exp + high_exp) // 2
    mid_val = n ** mid_exp

    if mid_val == x
      return true
    elsif mid_val < x
      low_exp = mid_exp + 1
    else
      high_exp = mid_exp - 1
    end
  end

  false
end