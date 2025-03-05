def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2

  intersection_start = [start1, start2].max
  intersection_end = [end1, end2].min

  if intersection_start > intersection_end
    "NO"
  else
    length = intersection_end - intersection_start + 1
    length.prime? ? "YES" : "NO"
  end
end