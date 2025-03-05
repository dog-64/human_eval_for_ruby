def median(numbers)
  return nil if numbers.empty?
  
  sorted = numbers.sort
  len = sorted.length
  mid = len / 2

  if len.even?
    (sorted[mid - 1] + sorted[mid]) / 2.0
  else
    sorted[mid]
  end
end