def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2

  if start1 > end2 || start2 > end1
    return "NO"
  end

  start = [start1, start2].max
  end = [end1, end2].min

  length = end - start + 1

  if length.prime?
    "YES"
  else
    "NO"
  end
end