def rolling_max(numbers)
  result = []
  current_max = -Float::INFINITY

  numbers.each_with_index do |number, index|
    current_max = [current_max, number].max
    result << current_max
  end

  result
end
