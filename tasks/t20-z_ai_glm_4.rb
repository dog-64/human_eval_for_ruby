
def find_closest_elements(numbers)
  raise ArgumentError, "List must contain at least two numbers" if numbers.size < 2

  sorted_numbers = numbers.sort
  min_diff = Float::INFINITY
  closest_pair = nil

  (0...sorted_numbers.size - 1).each do |i|
    num1 = sorted_numbers[i]
    num2 = sorted_numbers[i + 1]
    diff = (num2 - num1).abs

    if diff < min_diff
      min_diff = diff
      closest_pair = [num1, num2]
    end
  end

  closest_pair
end