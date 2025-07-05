def choose_num(x, y)
  if x > y
    return -1
  end

  largest_even = -1
  for i in x..y
    if i % 2 == 0
      largest_even = i
    end
  end

  largest_even
end
