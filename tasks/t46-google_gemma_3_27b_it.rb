def fib4(n)
  if n == 0
    0
  elsif n == 1
    0
  elsif n == 2
    2
  elsif n == 3
    0
  else
    a = 0
    b = 0
    c = 2
    d = 0
    (4..n).each do |i|
      next_val = a + b + c + d
      a = b
      b = c
      c = d
      d = next_val
    end
    d
  end
end