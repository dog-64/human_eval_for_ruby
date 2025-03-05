def rounded_avg(n, m)
  return -1 if n > m
  avg = (n..m).sum.to_f / (m - n + 1)
  "0b#{avg.round.to_s(2)}"
end