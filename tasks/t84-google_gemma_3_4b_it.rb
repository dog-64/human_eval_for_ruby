def sum_binary_digits(n)
  sum = 0
  while n > 0
    sum += n % 2
    n /= 2
  end
  sum.to_s(2)
end
