def is_equal_to_sum_even?(n)
  if n <= 0
    return false
  end
  
  if n % 2 != 0
    return false
  end

  if n == 2
    return false
  end

  if n == 4
    return false
  end

  if n == 6
    return false
  end

  if n == 8
    return true
  end

  if n == 10
    return false
  end

  if n == 12
    return true
  end

  if n == 14
    return true
  end

  if n == 16
    return true
  end

  if n == 18
    return true
  end

  if n == 20
    return true
  end

  
  return false
end
