def has_close_elements(numbers, threshold)
  return false if numbers.size < 2
  sorted_numbers = numbers.sort
  sorted_numbers.each_cons(2) do |a, b|
    return true if b - a <= threshold
  end
  false
end