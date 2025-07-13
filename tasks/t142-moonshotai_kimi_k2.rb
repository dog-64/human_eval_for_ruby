def sum_squares(lst)
  lst.each_with_index.sum do |value, index|
    if index % 3 == 0
      value ** 2
    elsif index % 4 == 0
      value ** 3
    else
      value
    end
  end
end