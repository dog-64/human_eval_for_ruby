def sort_third(l)
  third_elements = l.each_with_index.map { |val, idx| val if idx % 3 == 0 }.compact
  sorted_thirds = third_elements.sort
  result = []
  third_idx = 0
  l.each_with_index do |val, idx|
    if idx % 3 == 0
      result << sorted_thirds[third_idx]
      third_idx += 1
    else
      result << val
    end
  end
  result
end