def sort_third(l)
  indexed_l = l.each_with_index.to_a
  third_elements = indexed_l.select { |_, index| (index + 1) % 3 == 0 }.map(&:first).sort
  result = []
  third_index = 0
  indexed_l.each do |element, index|
    if (index + 1) % 3 == 0
      result << third_elements[third_index]
      third_index += 1
    else
      result << element
    end
  end
  result
end