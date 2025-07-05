def rounded_avg(n, m)
  return -1 if n > m
  sum = (n..m).sum
  count = m - n + 1
  average = sum.to_f / count
  rounded_average = average.round
  rounded_average.to_s(2)
end