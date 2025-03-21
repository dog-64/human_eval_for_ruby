def intersperse(numbers, delimeter)
  return [] if numbers.empty?
  result = []
  numbers.each_cons(2).with_index do |(a, b), i|
    result << a
    result << delimeter if i < numbers.length - 1
  end
  result
end
intersperse([1, 2, 3], 4) # => [1, 4, 2, 4, 3]