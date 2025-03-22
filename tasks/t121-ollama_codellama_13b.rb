def sum_odd_even_pos(lst)
  sum = 0
  lst.each_with_index do |num, index|
    if index % 2 == 0 && num.odd?
      sum += num
    end
  end
  return sum
end