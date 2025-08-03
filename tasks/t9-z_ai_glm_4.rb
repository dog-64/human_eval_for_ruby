
def rolling_max(numbers)
  return [] if numbers.empty?
  
  result = []
  current_max = numbers.first
  
  numbers.each do |num|
    current_max = num if num > current_max
    result << current_max
  end
  
  result
end