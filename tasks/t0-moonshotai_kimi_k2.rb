def has_close_elements(numbers, threshold)
  return false if numbers.size < 2
  
  numbers.each_with_index do |num, i|
    numbers[(i+1)..-1].each do |other|
      return true if (num - other).abs <= threshold
    end
  end
  
  false
end