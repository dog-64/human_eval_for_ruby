def sort_third(l)
  result = l.dup
  indices = (0...result.size).select { |i| i % 3 == 0 }
  sorted = indices.map { |i| result[i] }.sort
  indices.each_with_index { |i, idx| result[i] = sorted[idx] }
  result
end