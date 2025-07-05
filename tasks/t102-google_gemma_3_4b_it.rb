def choose_num(x, y)
  max_even = -1
  for i in x..y
    if i % 2 == 0
      max_even = i
    end
  end
  max_even
end
