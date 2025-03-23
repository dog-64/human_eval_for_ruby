
def move_one_ball(arr)
  return true if arr.empty?

  n = arr.length
  sorted_arr = arr.sort
  
  (0...n).each do |i|
    rotated_arr = arr.dup
    (0...i).each do |j|
      rotated_arr.insert(0, rotated_arr.pop)
    end
    
    if rotated_arr == sorted_arr
      return true
    end
  end
  
  return false
end
