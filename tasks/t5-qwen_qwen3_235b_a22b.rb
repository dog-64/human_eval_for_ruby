def intersperse(numbers, delimeter)
  result = []
  numbers.each_with_index do |num, i|
    result << num
    result << delimeter unless i == numbers.length - 1
  end
  result
end