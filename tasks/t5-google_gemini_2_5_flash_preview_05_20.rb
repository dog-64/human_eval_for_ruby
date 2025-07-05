def intersperse(numbers, delimeter)
  return [] if numbers.empty?

  result = []
  numbers.each_with_index do |num, index|
    result << num
    result << delimeter if index < numbers.length - 1
  end
  result
end