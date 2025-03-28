def rounded_avg(n, m)
  return -1 if n > m
  average = ((n + m) / 2.0).round
  "0b#{average.to_s(2)}"
end