def intersection(interval1, interval2)
  start = [interval1[0], interval2[0]].max
  finish = [interval1[1], interval2[1]].min
  return "NO" if start > finish
  length = finish - start + 1
  return "NO" if length <= 1
  limit = Math.sqrt(length).floor
  (2..limit).each do |i|
    return "NO" if length % i == 0
  end
  "YES"
end