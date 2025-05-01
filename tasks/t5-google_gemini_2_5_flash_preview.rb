def intersperse(numbers, delimeter)
  result = []
  numbers.each_with_index do |number, index|
    result << number
    result << delimeter unless index == numbers.length - 1
  end
  result
end