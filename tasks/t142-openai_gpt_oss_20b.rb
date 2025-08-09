def sum_squares(lst)
  sum = 0
  lst.each_with_index do |value, index|
    if index % 3 == 0
      sum += value * value
    elsif index % 4 == 0
      sum += value * value * value
    else
      sum += value
    end
  end
  sum
end