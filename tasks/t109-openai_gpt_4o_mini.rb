def move_one_ball(arr)
  return true if arr.empty?
  
  max_index = arr.each_with_index.max[1]
  rotated = arr[max_index..-1] + arr[0...max_index]
  
  rotated == rotated.sort
end