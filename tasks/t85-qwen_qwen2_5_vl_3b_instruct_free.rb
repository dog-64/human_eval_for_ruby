def add_even_at_odd(lst)
  lst.each_with_index.select { |_, index| index.odd? && lst[index].even? }.sum(&:last)
end