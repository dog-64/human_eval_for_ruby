def add_even_at_odd(lst)
  sum = 0
  lst.each_with_index do |num, idx|
    sum += num if idx.odd? && num.even?
  end
  sum
end