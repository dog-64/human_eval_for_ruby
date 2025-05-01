def sum_odd_even_pos(lst)
  lst.each_with_index.select { |_, index| index.even? && lst[index].odd? }.map(&:last).sum
end
