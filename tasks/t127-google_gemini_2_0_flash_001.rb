def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2

  intersection_start = [start1, start2].max
  intersection_end = [end1, end2].min

  intersection_length = intersection_end - intersection_start + 1

  if intersection_length <= 0
    return "NO"
  end

  if intersection_length == 1
    return "NO"
  end

  if intersection_length == 2
    return "YES"
  end

  if intersection_length % 2 == 0
    return "NO"
  end

  i = 3
  while i * i <= intersection_length
    if intersection_length % i == 0
      return "NO"
    end
    i += 2
  end

  return "YES"
end