def find_closest_elements(numbers)
  numbers.sort!
  min_diff = (numbers[1] - numbers[0]).abs
  closest_pair = [numbers[0], numbers[1]]
  numbers.each_cons(2) do |a, b|
    diff = (b - a).abs
    if diff < min_diff
      min_diff = diff
      closest_pair = [a, b]
    end
  end
  closest_pair
end