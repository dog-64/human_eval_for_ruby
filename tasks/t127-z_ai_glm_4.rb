def intersection(interval1, interval2)
  a1, b1 = interval1
  a2, b2 = interval2
  
  start = [a1, a2].max
  end_ = [b1, b2].min
  
  if start > end_
    return "NO"
  end
  
  length = end_ - start + 1
  
  if length < 2
    return "NO"
  end
  
  if length == 2
    return "YES"
  end
  
  if length % 2 == 0
    return "NO"
  end
  
  i = 3
  while i * i <= length
    if length % i == 0
      return "NO"
    end
    i += 2
  end
  
  "YES"
end