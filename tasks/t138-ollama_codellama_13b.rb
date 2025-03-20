def is_equal_to_sum_even?(n)
  return false if n < 0 || n % 2 != 0
  sum = 0
  4.times do |i|
    sum += (n - sum) / 2
  end
  sum == n
end
is_equal_to_sum_even?(4)  # false
is_equal_to_sum_even?(6)  # false
is_equal_to_sum_even?(8)  # true (2 + 2 + 2 + 2)
is_equal_to_sum_even?(12) # true (2 + 2 + 4 + 4)
is_equal_to_sum_even?(10) # false
is_equal_to_sum_even?(20) # true
is_equal_to_sum_even?(7)  # false