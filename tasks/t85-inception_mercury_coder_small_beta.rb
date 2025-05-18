def add_even_at_odd(lst)
  lst.each_with_index.select { |num, index| index.odd? && num.even? }.sum
end