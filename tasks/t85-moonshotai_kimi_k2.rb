def add_even_at_odd(lst)
  lst.each_slice(2).sum { |pair| pair[1]&.even? ? pair[1] : 0 }
end