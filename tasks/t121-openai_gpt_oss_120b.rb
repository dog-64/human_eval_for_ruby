def sum_odd_even_pos(lst)
  sum = 0
  lst.each_with_index do |val, idx|
    sum += val if idx.even? && val.odd?
  end
  sum
end