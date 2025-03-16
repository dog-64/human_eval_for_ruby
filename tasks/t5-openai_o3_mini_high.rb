def intersperse(numbers, delimeter)
  result = []
  numbers.each_with_index do |num, index|
    result << num
    result << delimeter if index < numbers.size - 1
  end
  result
end