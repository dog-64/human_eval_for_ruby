def fib4(n)
  return 0 if n <= 1
  return 2 if n == 2
  return 0 if n == 3
  a = [0, 0, 2, 0]
  (4..n).each do |i|
    a[i] = a[i - 1] + a[i - 2] + a[i - 3] + a[i - 4]
  end
  a[n]
end