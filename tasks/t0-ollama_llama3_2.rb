def has_close_elements(numbers, threshold)
  numbers.each_cons(2) do |a, b|
    return true if (b - a).abs <= threshold
  end
  false
end