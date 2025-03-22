def sum_squares(lst)
  lst.each_with_index.sum do |num, index|
    if index % 3 == 0
      num ** 2
    elsif index % 4 == 0
      num ** 3
    else
      num
    end
  end
end