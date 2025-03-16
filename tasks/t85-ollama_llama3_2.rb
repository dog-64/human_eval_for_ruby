def add_even_at_odd(lst)
  lst.each_cons(2).map { |a, b| (b.even? && a.odd?) ? b : 0 }.sum
end