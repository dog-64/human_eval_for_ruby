def fib4(n)
  return 0 if n == 0 || n == 1
  return 2 if n == 2
  return 0 if n == 3

  fib_numbers = [0, 0, 2, 0]

  (4..n).each do |i|
    next_fib = fib_numbers[0] + fib_numbers[1] + fib_numbers[2] + fib_numbers[3]
    fib_numbers.shift
    fib_numbers << next_fib
  end

  fib_numbers.last
end