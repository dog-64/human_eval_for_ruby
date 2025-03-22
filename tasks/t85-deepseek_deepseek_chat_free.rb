def add_even_at_odd(lst)
  lst.select.with_index { |num, idx| idx.odd? && num.even? }.sum
end
