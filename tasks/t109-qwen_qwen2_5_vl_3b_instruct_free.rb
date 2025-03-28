def move_one_ball(arr)
  return true if arr.empty?
  
  arr.each_cons(2).each do |a, b|
    return false if a > b
  end
  
  true
end