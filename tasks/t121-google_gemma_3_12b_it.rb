def sum_odd_even_pos(lst)
  sum = 0
  lst.each_with_index do |num, index|
    if index.even? && num.odd?
      sum += num
    end
  end
  sum
end
