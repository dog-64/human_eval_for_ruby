
def add_even_at_odd(lst)
  lst.each_with_index.sum { |num, i| num.even? && i.odd? ? num : 0 }
end

 