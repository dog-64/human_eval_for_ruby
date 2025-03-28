def sort_even_elements(list)
  return [] if list.empty?
  even_indices = list.each_index.select(&:even?)
  even_elements = even_indices.map { |i| list[i] }.sort
  result = list.dup
  even_indices.each_with_index { |original_idx, sorted_idx| result[original_idx] = even_elements[sorted_idx] }
  result
end