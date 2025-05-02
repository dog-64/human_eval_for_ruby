def find_closest_elements(numbers)
  raise ArgumentError if numbers.length < 2
  sorted = numbers.sort
  closest = nil
  min_diff = Float::INFINITY

  sorted.each_cons(2) do |a, b|
    current_diff = (b - a).abs
    if current_diff < min_diff
      min_diff = current_diff
      closest = [a, b]
    end
  end

  closest
end