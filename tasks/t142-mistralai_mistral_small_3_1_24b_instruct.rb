def sum_squares(lst)
  lst.map.with_index do |num, index|
    if index % 3 == 0
      num ** 2
    elsif index % 4 == 0
      num ** 3
    else
      num
    end
  end.sum
end