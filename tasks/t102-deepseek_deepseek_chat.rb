def choose_num(x, y)
  start = [x, y].min
  finish = [x, y].max
  max_even = -1
  (start..finish).each do |num|
    max_even = num if num.even? && num > max_even
  end
  max_even
end