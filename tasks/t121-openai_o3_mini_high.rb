def sum_odd_even_pos(lst)
  sum = 0
  lst.each_with_index do |num, index|
    sum += num if index.even? && num.odd?
  end
  sum
end