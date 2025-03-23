
def is_equal_to_sum_even?(n)
  if n <= 0
    return false
  end

  if n % 2 != 0
    return false
  end

  if n < 8
    return false
  end

  return true
end
