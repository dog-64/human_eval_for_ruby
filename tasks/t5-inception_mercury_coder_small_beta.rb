def intersperse(numbers, delimiter)
  return [] if numbers.empty?
  result = [numbers.first]
  numbers[1..-1].each do |num|
    result << delimiter
    result << num
  end
  result
end