def can_arrange(arr)
  return -1 if arr.empty? || arr.size == 1

  last_index = -1
  (1...arr.size).each do |i|
    last_index = i if arr[i] < arr[i - 1]
  end

  last_index
end