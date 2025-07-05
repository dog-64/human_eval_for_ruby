def is_prime(n)
  return false if n <= 1
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end

def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2

  intersection_start = [start1, start2].max
  intersection_end = [end1, end2].min

  if intersection_start > intersection_end
    "NO"
  else
    intersection_length = intersection_end - intersection_start + 1
    if is_prime(intersection_length)
      "YES"
    else
      "NO"
    end
  end
end