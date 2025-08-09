def rolling_max(numbers)
  result = []
  current_max = nil
  numbers.each do |num|
    current_max = num if current_max.nil? || num > current_max
    result << current_max
  end
  result
end