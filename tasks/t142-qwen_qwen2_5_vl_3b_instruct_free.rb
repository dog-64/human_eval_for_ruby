def sum_squares(lst)
  lst.each_with_index.map do |num, idx|
    if idx % 3 == 0
      num ** 2
    elsif idx % 4 == 0
      num ** 3
    else
      num
    end
  end.sum
end