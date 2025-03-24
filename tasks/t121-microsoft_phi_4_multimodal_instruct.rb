def sum_odd_even_pos(lst)
  lst.each_with_index.reduce(0) { |sum, (num, index)| index.even? && num.odd? ? sum + num : sum }
end