def is_equal_to_sum_even?(n)
  return false if n < 0 || n % 2 != 0
  sum = 0
  4.times do |i|
    sum += (n - sum).div(2)
  end
  sum == n
end