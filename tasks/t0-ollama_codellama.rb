def has_close_elements(numbers, threshold)
  return false if numbers.empty?
  return false if numbers.size == 1

  numbers.each_cons(2) do |a, b|
    return true if (b - a).abs <= threshold
  end

  false
end