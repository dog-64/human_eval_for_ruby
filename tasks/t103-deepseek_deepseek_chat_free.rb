def rounded_avg(n, m)
  return -1 if n > m
  average = (n..m).sum.to_f / (m - n + 1)
  rounded = average.round
  "0b" + rounded.to_s(2)
end
