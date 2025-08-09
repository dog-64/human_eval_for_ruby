def fib4(n)
  return 0 if n == 0 || n ==1 || n == 3
  return 2 if n == 2
  a0 = 0
  a1 = 0
  a2 = 2
  a3 = 0
  (4..n).each do
    a4 = a0 + a1 + a2 + a3
    a0, a1, a2, a3 = a1, a2, a3, a4
  end
  a3
end