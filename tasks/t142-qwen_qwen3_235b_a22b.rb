def sum_squares(lst)
  lst.each_with_index.sum do |num, i|
    if i % 3 == 0
      num ** 2
    elsif i % 4 == 0
      num ** 3
    else
      num
    end
  end
end