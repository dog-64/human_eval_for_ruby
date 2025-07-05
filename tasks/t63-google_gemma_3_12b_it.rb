def fibfib(n)
  if n == 0
    0
  elsif n == 1
    0
  elsif n == 2
    1
  else
    fib_array = [0, 0, 1]
    (3..n).each do |i|
      next_fib = fib_array[i - 1] + fib_array[i - 2] + fib_array[i - 3]
      fib_array[i] = next_fib
    end
    fib_array[n]
  end
end
