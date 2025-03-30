
def find_closest_elements(numbers)
  raise ArgumentError, 'List must contain at least two elements' if numbers.size < 2

  sorted = numbers.sort
  min_diff = Float::INFINITY
  closest_pair = nil

  sorted.each_cons(2) do |a, b|
    current_diff = b - a
    if current_diff < min_diff
      min_diff = current_diff
      closest_pair = [a, b]
    end
  end

  closest_pair
end

 