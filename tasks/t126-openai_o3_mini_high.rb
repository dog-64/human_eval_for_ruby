def is_sorted?(lst)
  (0...lst.size - 1).each do |i|
    return false if lst[i] > lst[i + 1]
  end
  lst.each_cons(3) do |a, b, c|
    return false if a == b && b == c
  end
  true
end