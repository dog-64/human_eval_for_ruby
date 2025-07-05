def is_equal_to_sum_even?(n)
  return false if n < 8
  return true if n % 2 == 0 && n >= 8
  false
end
