def rounded_avg(n, m)
  return -1 if n > m
  sum = (n..m).sum
  avg = sum / (m - n + 1)
  "#{'0b' + avg.to_s(2)}"
end