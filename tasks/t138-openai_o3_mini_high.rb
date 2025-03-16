def is_equal_to_sum_even?(n)
  return false if n < 8 || n.odd?
  n % 4 == 0
end