def rounded_avg(n, m)
  return -1 if n > m

  sum = (n..m).sum
  avg = sum.to_f / (m - n + 1)
  avg.round.to_s(2) == "0b" ? "0b" + avg.to_s(2) : avg.to_s(2)
end
