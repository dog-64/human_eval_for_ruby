def sum_squares(lst)
  sum = 0
  lst.each_with_index do |item, index|
    if index % 3 == 0
      sum += item ** 2
    elsif index % 4 == 0
      sum += item ** 3
    else
      sum += item
    end
  end
  sum
end