def rolling_max(numbers)
  return [] if numbers.empty?
  return numbers if numbers.size == 1

  max_values = []
  numbers.each do |number|
    max_values << number if max_values.empty? || number > max_values.last
  end

  return max_values
end