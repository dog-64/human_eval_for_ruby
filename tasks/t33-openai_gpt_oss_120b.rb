def sort_third(l)
  result = l.dup
  indices = (0...l.length).select { |i| i % 3 == 0 }
  sorted_vals = indices.map { |i| l[i] }.sort
  indices.each_with_index { |idx, j| result[idx] = sorted_vals[j] }
  result
end