def rounded_avg(n, m)
  return -1 if n > m
  avg = (n + m) / 2.0
  rounded_value = avg.round
  "0b" + rounded_value.to_s(2)
end