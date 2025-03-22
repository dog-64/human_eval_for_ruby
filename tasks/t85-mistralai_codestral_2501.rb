def add_even_at_odd(lst)
  lst.select.with_index { |_, i| i.odd? }.select(&:even?).sum
end