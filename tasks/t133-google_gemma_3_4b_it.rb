def sum_squares(lst)
  sum = 0
  lst.each do |num|
    rounded_up = num.ceil
    sum += rounded_up * rounded_up
  end
  sum
end
