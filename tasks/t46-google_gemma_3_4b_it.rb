def fib4(n)
  if n == 0 || n == 1
    return 0
  elsif n == 2
    return 2
  elsif n == 3
    return 0
  else
    fib_values = [0, 0, 2, 0]
    (4..n).each do |i|
      next_fib = fib_values[i - 1] + fib_values[i - 2] + fib_values[i - 3] + fib_values[i - 4]
      fib_values << next_fib
    end
    return fib_values[n]
  end
end
