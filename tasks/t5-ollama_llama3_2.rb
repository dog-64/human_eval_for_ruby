def intersperse(numbers, delimeter)
  return [] if numbers.empty?
  result = [numbers.first]
  numbers[1..-1].each { |n| result << n << delimeter }
  result << numbers.last
end