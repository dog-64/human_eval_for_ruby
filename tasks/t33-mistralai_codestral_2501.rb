def sort_third(l)
  third_indices = l.each_index.select { |i| (i + 1) % 3 == 0 }
  third_elements = third_indices.map { |i| l[i] }.sort
  l.each_with_index.map do |value, index|
    third_indices.include?(index) ? third_elements.shift : value
  end
end