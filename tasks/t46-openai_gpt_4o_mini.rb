def fib4(n)
  return n if n < 2
  fib = [0, 0, 2, 0]
  (4..n).each do |i|
    fib[i % 4] = fib.sum
  end
  fib[n % 4]
end