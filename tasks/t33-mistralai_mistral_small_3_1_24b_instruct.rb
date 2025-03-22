def sort_third(l)
  third_elements = l.select.with_index { |_, i| (i + 1) % 3 == 0 }
  sorted_third_elements = third_elements.sort
  result = l.dup
  sorted_third_elements.each_with_index do |value, index|
    result[index * 3] = value
  end
  result
end