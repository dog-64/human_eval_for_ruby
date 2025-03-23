def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2

  intersection_start = [start1, start2].max
  intersection_end = [end1, end2].min

  if intersection_start > intersection_end
    return "NO"
  end

  length = intersection_end - intersection_start + 1

  if length <= 1
    return "NO"
  end

  is_prime = true
  (2..Math.sqrt(length)).each do |i|
    if length % i == 0
      is_prime = false
      break
    end
  end

  if is_prime
    return "YES"
  else
    return "NO"
  end
end