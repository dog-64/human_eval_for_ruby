def move_one_ball(arr)
  return true if arr.empty?

  sorted_arr = arr.sort
  n = arr.length

  (0...n).each do |i|
    if arr == sorted_arr
      return true
    end
    arr.unshift(arr.pop)
  end

  false
end