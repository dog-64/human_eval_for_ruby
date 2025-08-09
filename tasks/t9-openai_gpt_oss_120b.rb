def rolling_max(numbers)
  result = []
  max = nil
  numbers.each do |num|
    max = max.nil? ? num : (max > num ? max : num)
    result << max
  end
  result
end