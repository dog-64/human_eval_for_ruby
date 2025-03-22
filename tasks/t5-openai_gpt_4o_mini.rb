def intersperse(numbers, delimeter)
  return [] if numbers.empty?
  numbers.flat_map { |num| [num, delimeter] }.tap { |arr| arr.pop }
end