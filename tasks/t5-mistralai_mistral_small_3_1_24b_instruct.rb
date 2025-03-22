def intersperse(numbers, delimiter)
  return [] if numbers.empty?
  result = []
  numbers.each_with_index do |number, index|
    result << number
    result << delimiter unless index == numbers.size - 1
  end
  result
end