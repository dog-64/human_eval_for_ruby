def can_arrange(arr)
  arr.each_cons(2).with_index do |(a, b), i|
    return i + 1 if b < a
  end
  -1
end