def fib4(n)
  case n
  when 0 then 0
  when 1 then 0
  when 2 then 2
  when 3 then 0
  else
    a, b, c, d = 0, 0, 2, 0
    (n - 3).times do
      current = a + b + c + d
      a, b, c, d = b, c, d, current
    end
    d
  end
end