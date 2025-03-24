def rounded_avg(n, m)
  return -1 if n > m
  avg = (n + m).to_f / 2
  (avg.round.to_i).to_s(2).prepend('0b')
end
