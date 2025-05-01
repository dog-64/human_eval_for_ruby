def can_arrange(arr)
  return -1 if arr.empty?

  last_decreasing_index = -1
  (1...arr.length).each do |i|
    if arr[i] < arr[i - 1]
      last_decreasing_index = i
    end
  end
  last_decreasing_index
end
