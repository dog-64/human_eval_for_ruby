def sort_third(l)
  indices = (2...l.size).step(3).to_a
  sorted_values = l.values_at(*indices).sort
  l.map.with_index { |val, idx| indices.include?(idx) ? sorted_values.shift : val }
end