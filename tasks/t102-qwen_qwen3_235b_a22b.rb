def choose_num(x, y)
  return -1 if x > y

  max_even = y.even? ? y : y - 1
  max_even >= x ? max_even : -1
end