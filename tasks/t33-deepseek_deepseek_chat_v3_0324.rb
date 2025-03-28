def sort_third(l)
  result = l.dup
  indices = (0...l.size).select { |i| i % 3 == 0 }
  values = indices.map { |i| l[i] }.sort
  indices.each_with_index { |original_index, sorted_index| result[original_index] = values[sorted_index] }
  result
end