def is_equal_to_sum_even?(n)
  return false if n < 0
  (1..n/4).any? { |i| i.even? && ((n - i) % 2 == 0 && (n - i)/2 >= 1) }
end