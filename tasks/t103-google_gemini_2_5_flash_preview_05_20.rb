def rounded_avg(n, m)
  return -1 if n > m

  sum = (n..m).sum
  count = m - n + 1
  average = sum.to_f / count
  rounded = average.round
  "0b" + rounded.to_s(2)
end