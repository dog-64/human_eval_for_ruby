def rounded_avg(n, m)
  return -1 if n > m
  avg = (n + m) / 2
  "0b" + avg.to_s(2)
end