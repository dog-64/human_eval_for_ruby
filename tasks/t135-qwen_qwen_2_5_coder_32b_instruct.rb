def can_arrange(arr)
  return -1 if arr.empty?

  index = -1
  (1...arr.size).each do |i|
    index = i if arr[i] < arr[i - 1]
  end

  index
end