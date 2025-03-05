def rounded_avg(n, m)
  return -1 if n > m

  sum = 0
  (n..m).each do |i|
    sum += i
  end

  avg = (sum.to_f / (m - n + 1)).round

  "0b" + avg.to_i.to_s(2)
end