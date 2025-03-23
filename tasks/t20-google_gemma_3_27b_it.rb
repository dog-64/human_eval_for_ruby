
def find_closest_elements(numbers)
  raise ArgumentError, "List must contain at least two numbers" if numbers.length < 2

  numbers.sort!
  min_diff = Float::INFINITY
  closest_pair = []

  numbers.each_with_index do |num1, index|
    num2 = numbers[index + 1]
    diff = (num2 - num1).abs

    if diff < min_diff
      min_diff = diff
      closest_pair = [num1, num2]
    end
  end

  closest_pair
end
