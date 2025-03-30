
def rolling_max(numbers)
  return [] if numbers.empty?

  result = []
  current_max = numbers.first
  result << current_max

  numbers[1..-1].each do |num|
    current_max = [current_max, num].max
    result << current_max
  end

  result
end

 