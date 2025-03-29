def intersperse(numbers, delimiter)
  result = []
  numbers.each_with_index do |num, index|
    result << num
    result << delimiter if index < numbers.length - 1
  end
  result
end