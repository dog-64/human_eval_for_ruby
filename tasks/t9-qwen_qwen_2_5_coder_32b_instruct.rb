def rolling_max(numbers)
  return [] if numbers.empty?
  
  max_so_far = numbers[0]
  result = [max_so_far]
  
  (1...numbers.length).each do |i|
    max_so_far = [max_so_far, numbers[i]].max
    result << max_so_far
  end
  
  result
end