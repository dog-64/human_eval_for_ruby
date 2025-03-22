def intersperse(numbers, delimeter)
  return [] if numbers.empty?
  result = []
  numbers.each_cons(2).with_index do |(a, b), i|
    result << a
    result << delimeter if i < numbers.size - 1
  end
  result
end