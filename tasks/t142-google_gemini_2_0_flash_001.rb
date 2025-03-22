def sum_squares(lst)
  sum = 0
  lst.each_with_index do |num, index|
    if (index + 1) % 3 == 0
      sum += num ** 2
    elsif (index + 1) % 4 == 0
      sum += num ** 3
    else
      sum += num
    end
  end
  sum
end