def sum_squares(lst)
  lst.map.with_index do |val, idx|
    if idx % 3 == 0
      val ** 2
    elsif idx % 4 == 0
      val ** 3
    else
      val
    end
  end.sum
end