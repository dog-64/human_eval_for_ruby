def can_arrange(arr)
  index = -1
  (1...arr.length).each do |i|
    index = i if arr[i] < arr[i - 1]
  end
  index
end