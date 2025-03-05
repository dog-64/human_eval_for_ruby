def sum_squares(lst)
  lst.each_with_index.reduce(0) do |sum, (num, idx)|
    if idx % 3 == 0
      sum + num ** 2
    elsif idx % 4 == 0
      sum + num ** 3
    else
      sum + num
    end
  end
end