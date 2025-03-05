def get_positive(numbers)
  positive_numbers = []
  if numbers.nil? || numbers.empty?
    return positive_numbers
  end

  numbers.each do |number|
    if number.is_a?(Numeric) && number > 0
      positive_numbers << number
    end
  end

  return positive_numbers
end