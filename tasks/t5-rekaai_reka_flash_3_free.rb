
def intersperse(numbers, delimiter)
  return numbers if numbers.empty? || numbers.size <= 1

  result = []
  numbers.each_with_index do |num, index|
    result << num
    result << delimiter unless index == numbers.length - 1
  end
  result
end

 