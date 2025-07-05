def intersperse(numbers, delimeter)
  return [] if numbers.empty?
  numbers.inject do |result, element|
    result + [delimeter, element]
  end
end