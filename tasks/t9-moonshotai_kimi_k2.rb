def rolling_max(numbers)
  max_so_far = nil
  numbers.each_with_object([]) do |num, result|
    max_so_far = max_so_far.nil? ? num : [max_so_far, num].max
    result << max_so_far
  end
end