def sum_odd_even_pos(lst)
  sum = 0
  lst.each_with_index do |num, index|
    if index % 2 == 0 && num % 2 != 0
      sum += num
    end
  end
  sum
end