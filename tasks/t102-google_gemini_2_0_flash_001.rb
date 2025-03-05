def choose_num(x, y)
  if x > y
    return -1
  end

  largest_even = -1
  y.downto(x) do |i|
    if i % 2 == 0
      largest_even = i
      break
    end
  end

  return largest_even
end