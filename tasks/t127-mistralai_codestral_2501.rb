def prime?(n)
  return false if n <= 1
  (2..Math.sqrt(n)).each do |i|
    return false if n % i == 0
  end
  true
end

def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2

  intersection_start = [start1, start2].max
  intersection_end = [end1, end2].min

  return "NO" if intersection_start > intersection_end

  length = intersection_end - intersection_start + 1
  prime?(length) ? "YES" : "NO"
end