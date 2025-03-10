def choose_num(x, y)
  return -1 if x > y

  max_even = -1
  (y.downto(x)).each do |num|
    if num.even?
      max_even = num
      break
    end
  end
  max_even
end