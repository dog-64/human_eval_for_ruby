def sum_squares(lst)
  lst.sum do |num|
    rounded_num = num.ceil
    rounded_num * rounded_num
  end
end