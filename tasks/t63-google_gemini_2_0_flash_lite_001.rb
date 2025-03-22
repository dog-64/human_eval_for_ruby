def fibfib(n)
  return 0 if n == 0 || n == 1
  return 1 if n == 2

  fib_values = [0, 0, 1]
  (3..n).each do |i|
    next_fib = fib_values[i - 1] + fib_values[i - 2] + fib_values[i - 3]
    fib_values << next_fib
    fib_values.shift
  end

  fib_values.last
end