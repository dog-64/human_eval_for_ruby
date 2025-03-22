def find_closest_elements(numbers)
  raise ArgumentError, 'List cannot be empty' if numbers.empty?
  raise ArgumentError, 'List must contain at least two numbers' if numbers.size == 1

  numbers.sort!
  min_diff = numbers[1] - numbers[0]
  closest_elements = [numbers[0], numbers[1]]

  (2...numbers.size).each do |i|
    diff = numbers[i] - numbers[i - 1]
    if diff < min_diff
      min_diff = diff
      closest_elements = [numbers[i - 1], numbers[i]]
    end
  end

  closest_elements
end