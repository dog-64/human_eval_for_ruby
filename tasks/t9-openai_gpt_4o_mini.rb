def rolling_max(numbers)
  max_so_far = nil
  numbers.map do |num|
    max_so_far = [num, max_so_far].compact.max
  end
end