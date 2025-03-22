def even_odd_count(num)
  num = abs(num)
  even = 0
  odd = 0
  while num > 0
    digit = num % 10
    if digit.even?
      even += 1
    else
      odd += 1
    end
    num /= 10
  end
  [even, odd]
end