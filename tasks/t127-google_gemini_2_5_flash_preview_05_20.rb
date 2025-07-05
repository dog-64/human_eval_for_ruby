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

  (2..Math.sqrt(length)).each do |i|
    if length % i == 0
      return "NO"
    end
  end

  "YES"
end