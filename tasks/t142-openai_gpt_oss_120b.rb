def sum_squares(lst)
  total = 0
  lst.each_with_index do |val, idx|
    if idx % 3 == 0
      total += val * val
    elsif idx % 4 == 0
      total += val ** 3
    else
      total += val
    end
  end
  total
end