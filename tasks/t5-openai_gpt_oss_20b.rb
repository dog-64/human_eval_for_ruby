def intersperse(numbers, delimeter)
  return [] if numbers.empty?
  result = []
  numbers.each_with_index do |num, idx|
    result << num
    result << delimeter unless idx == numbers.size - 1
  end
  result
end