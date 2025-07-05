def sum_squares(lst)
  modified_sum = 0
  lst.each_with_index do |num, index|
    if (index + 1) % 3 == 0
      modified_sum += num**2
    elsif (index + 1) % 4 == 0
      modified_sum += num**3
    else
      modified_sum += num
    end
  end
  modified_sum
end