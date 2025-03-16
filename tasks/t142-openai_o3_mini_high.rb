def sum_squares(lst)
  lst.each_with_index.sum do |x, i|
    if i % 3 == 0
      x ** 2
    elsif i % 4 == 0
      x ** 3
    else
      x
    end
  end
end