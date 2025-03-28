def add_even_at_odd(lst)
  lst.each_with_index.sum { |num, index| index.odd? && num.even? ? num : 0 }
end