def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2

  intersection_start = [start1, start2].max
  intersection_end = [end1, end2].min

  if intersection_start <= intersection_end
    length = intersection_end - intersection_start + 1
    is_prime?(length) ? "YES" : "NO"
  else
    "NO"
  end
end

def is_prime?(num)
  return false if num <= 1
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end