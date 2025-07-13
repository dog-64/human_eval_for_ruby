def sort_third(l)
  return [] if l.empty?
  
  third_indices = (0...l.size).select { |i| (i + 1) % 3 == 0 }
  third_values = third_indices.map { |i| l[i] }.sort
  
  result = l.dup
  third_indices.each_with_index do |original_index, sorted_index|
    result[original_index] = third_values[sorted_index]
  end
  
  result
end