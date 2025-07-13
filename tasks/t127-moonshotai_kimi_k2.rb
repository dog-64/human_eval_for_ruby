def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2
  
  intersection_start = [start1, start2].max
  intersection_end = [end1, end2].min
  
  return "NO" if intersection_start > intersection_end
  
  length = intersection_end - intersection_start + 1
  
  return "NO" if length < 2
  
  is_prime = true
  (2..Math.sqrt(length)).each do |i|
    if length % i == 0
      is_prime = false
      break
    end
  end
  
  is_prime ? "YES" : "NO"
end