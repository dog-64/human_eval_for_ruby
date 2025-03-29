def rolling_max(numbers)
  max_so_far = []
  max_so_far << numbers[0] if numbers.length > 0
  numbers.each_with_index do |num, i|
    max_so_far << [max_so_far[i], num].max
  end
  max_so_far
end