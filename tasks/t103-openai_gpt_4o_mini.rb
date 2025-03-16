def rounded_avg(n, m)
  return -1 if n > m
  avg = (n + m) / 2.0
  rounded = avg.round
  "0b#{rounded.to_s(2)}"
end