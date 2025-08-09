def can_arrange(arr)
  last_index = -1
  (1...arr.length).each do |i|
    last_index = i if arr[i] < arr[i - 1]
  end
  last_index
end