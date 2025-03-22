def choose_num(x, y)
  if x > y
    return -1
  end
  max_even = -1
  (x..y).each do |num|
    if num.even? && num > max_even
      max_even = num
    end
  end
  max_even
end