def rolling_max(numbers)
  result = []
  current_max = -Float::INFINITY

  numbers.each do |number|
    current_max = [current_max, number].max
    result << current_max
  end

  result
end
