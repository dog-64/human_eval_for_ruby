def move_one_ball(arr)
  return true if arr.empty?
  n = arr.length
  
  if n == 1
    return true
  end

  sorted_arr = arr.sort
  
  if arr == sorted_arr
    return true
  end

  for _ in 0..(n - 1)
    temp_arr = arr.dup
    last_element = temp_arr.pop
    temp_arr.insert(0, last_element)
    
    if temp_arr == sorted_arr
      return true
    end
  end

  false
end
