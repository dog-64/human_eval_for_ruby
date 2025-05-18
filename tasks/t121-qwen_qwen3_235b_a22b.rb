def sum_odd_even_pos(lst)
  sum = 0
  lst.each_with_index do |num, idx|
    sum += num if idx.even? && num.odd?
  end
  sum
end