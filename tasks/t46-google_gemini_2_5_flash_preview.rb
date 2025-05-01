def fib4(n)
  if n == 0
    return 0
  elsif n == 1
    return 0
  elsif n == 2
    return 2
  elsif n == 3
    return 0
  end

  fib_sequence = [0, 0, 2, 0]

  (4..n).each do |i|
    next_fib = fib_sequence[i - 1] + fib_sequence[i - 2] + fib_sequence[i - 3] + fib_sequence[i - 4]
    fib_sequence << next_fib
  end

  fib_sequence[n]
end
