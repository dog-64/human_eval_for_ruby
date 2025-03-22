def rolling_max(numbers)
  current_max = nil
  numbers.map do |num|
    current_max = num if current_max.nil? || num > current_max
    current_max
  end
end