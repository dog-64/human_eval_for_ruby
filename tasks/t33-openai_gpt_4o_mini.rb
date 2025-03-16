def sort_third(l)
  sorted_third = l.each_with_index.select { |_, idx| idx % 3 == 0 }.map(&:first).sort
  l.each_with_index.map { |val, idx| idx % 3 == 0 ? sorted_third.shift : val }
end