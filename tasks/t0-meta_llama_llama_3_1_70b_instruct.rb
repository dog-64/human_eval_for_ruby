def has_close_elements(numbers, threshold)
  numbers.sort.each_cons(2).any? { |a, b| (a - b).abs <= threshold }
end
