def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2
  start = [start1, start2].max
  end_ = [end1, end2].min
  if start > end_
    return "NO"
  end
  length = end_ - start + 1
  return "YES" if is_prime?(length)
  "NO"
end

def is_prime?(n)
  return false if n <= 1
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end