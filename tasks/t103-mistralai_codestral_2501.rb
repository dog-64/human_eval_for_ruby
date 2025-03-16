def rounded_avg(n, m)
  return -1 if n > m

  sum = (n..m).sum
  count = m - n + 1
  avg = (sum.to_f / count).round
  avg.to_s(2).prepend("0b")
end