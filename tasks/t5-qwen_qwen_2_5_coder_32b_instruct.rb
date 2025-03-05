def intersperse(numbers, delimeter)
  return numbers if numbers.empty?
  
  result = []
  numbers.each_with_index do |num, index|
    result << num
    result << delimeter unless index == numbers.length - 1
  end
  result
end