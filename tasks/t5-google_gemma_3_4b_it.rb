def intersperse(numbers, delimeter)
  result = []
  numbers.each_with_index do |number, index|
    result << number
    if index < numbers.length - 1
      result << delimeter
    end
  end
  result
end
