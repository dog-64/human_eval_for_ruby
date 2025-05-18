def is_equal_to_sum_even?(n)
  return false if n < 8
  n.even? && (n / 2) >= 4
end