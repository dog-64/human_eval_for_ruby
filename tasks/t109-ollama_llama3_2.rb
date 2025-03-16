def move_one_ball(arr)
  return true if arr.empty?
  a = arr.dup
  until a == arr
    a.rotate!
  end
  false
end