def intersection(interval1, interval2)
  start_int = [interval1[0], interval2[0]].max
  end_int = [interval1[1], interval2[1]].min
  len = end_int - start_int
  return "NO" if len <= 0
  return "NO" if len < 2
  (2..Math.sqrt(len).to_i).each do |i|
    return "NO" if len % i == 0
  end
  "YES"
end