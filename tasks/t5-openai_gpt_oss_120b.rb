def intersperse(numbers, delimeter)
  return [] if numbers.empty?
  result = []
  numbers.each_with_index do |num, i|
    result << num
    result << delimeter if i < numbers.size - 1
  end
  result
end