def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2

  intersection_start = [start1, start2].max
  intersection_end = [end1, end2].min

  if intersection_start >= intersection_end
    return "NO"
  end

  intersection_length = intersection_end - intersection_start + 1

  if intersection_length <= 1
    return "NO"
  end

  is_prime = true
  (2..Math.sqrt(intersection_length)).each do |i|
    if intersection_length % i == 0
      is_prime = false
      break
    end
  end

  is_prime ? "YES" : "NO"
end
