def sum_squares(lst)
  sum = 0
  lst.each do |num|
    sum += num.ceil ** 2
  end
  sum
end