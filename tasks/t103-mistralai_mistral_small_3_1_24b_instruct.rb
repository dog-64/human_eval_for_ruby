def rounded_avg(n, m)
  return -1 if n > m

  count = m - n + 1
  sum = (n + m) * count / 2
  avg = (sum / count).round
  "0b#{avg.to_s(2)}"
end