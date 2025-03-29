def choose_num(x, y)
  start, stop = [x, y].minmax
  max_even = -1
  (start..stop).each do |num|
    max_even = num if num.even? && num > max_even
  end
  max_even
end