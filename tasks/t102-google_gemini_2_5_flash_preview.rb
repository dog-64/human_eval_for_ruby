def choose_num(x, y)
  if x > y
    return -1
  end

  if y.even?
    return y
  elsif (y - 1) >= x
    return y - 1
  else
    return -1
  end
end