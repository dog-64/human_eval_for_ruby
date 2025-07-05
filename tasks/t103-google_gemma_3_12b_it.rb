def rounded_avg(n, m)
  if n > m
    return -1
  end
  sum = (n..m).sum
  avg = sum.to_f / (m - n + 1)
  rounded_avg = avg.round
  "0b#{rounded_avg.to_s(2)}"
end
