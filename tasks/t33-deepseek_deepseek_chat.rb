def sort_third(l)
    indices = (0...l.length).step(3).to_a
    sorted = l.values_at(*indices).sort
    indices.each_with_index { |orig_idx, sorted_idx| l[orig_idx] = sorted[sorted_idx] }
    l
end