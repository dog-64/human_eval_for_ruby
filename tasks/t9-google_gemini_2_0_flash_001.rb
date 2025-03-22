def rolling_max(numbers)
  result = []
  max_so_far = nil
  numbers.each do |number|
    if max_so_far.nil? || number > max_so_far
      max_so_far = number
    end
    result << max_so_far
  end
  result
end