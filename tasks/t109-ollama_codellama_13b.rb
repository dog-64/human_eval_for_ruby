def move_one_ball(arr)
  return true if arr.empty?

  sorted = arr.sort
  (arr.size - 1).times do |i|
    if sorted[i + 1] < sorted[i]
      return false
    end
  end

  return true
end