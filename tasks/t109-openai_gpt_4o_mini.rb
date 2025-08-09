def move_one_ball(arr)
  return true if arr.empty?
  count = 0
  arr.each_with_index do |num, index|
    if index > 0 && num < arr[index - 1]
      count += 1
    end
  end
  count <= 1
end