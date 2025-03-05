def is_equal_to_sum_even?(n)
  return false if n < 8
  return false if n % 2 != 0
  return true if n >= 8 && n % 2 == 0
end