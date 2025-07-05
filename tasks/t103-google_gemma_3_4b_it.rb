def rounded_avg(n, m)
  if n > m
    return -1
  end

  total = 0
  count = 0
  (n..m).each do |i|
    total += i
    count += 1
  end

  average = total.to_f / count
  rounded_average = average.round

  "0b#{rounded_average.to_s(2)}"
end
