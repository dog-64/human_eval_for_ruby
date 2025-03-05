def rescale_to_unit(numbers)
  raise ArgumentError, "List must contain at least two elements" if numbers.length < 2
  
  min_val = numbers.min
  max_val = numbers.max
  
  if min_val == max_val
    return Array.new(numbers.length, 0.0) 
  end
  
  rescaled_numbers = numbers.map { |x| (x - min_val) / (max_val - min_val).to_f }
  
  return rescaled_numbers
end