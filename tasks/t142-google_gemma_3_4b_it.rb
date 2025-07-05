def sum_squares(lst)
  sum = 0
  lst.each_with_index do |num, index|
    if index % 3 == 0
      sum += num * num
    elsif index % 4 == 0 && index % 3 != 0
      sum += num * num * num
    end
  end
  sum
end
