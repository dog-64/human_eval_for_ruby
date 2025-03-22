def intersperse(numbers, delimeter)
  result = []
  numbers.each_with_index do |number, index|
    result << number
    result << delimeter if index < numbers.length - 1
  end
  result
end