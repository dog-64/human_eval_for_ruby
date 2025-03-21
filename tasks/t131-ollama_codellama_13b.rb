def digits(n)
  result = 1
  while n > 0
    digit = n % 10
    if digit.odd?
      result *= digit
    end
    n /= 10
  end
  return result
end