def move_one_ball(arr)
  return true if arr.empty?

  n = arr.length
  sorted_arr = arr.sort
  
  n.times do
    if arr == sorted_arr
      return true
    end
    
    last = arr.pop
    arr.unshift(last)
  end
  
  return false
end