def can_arrange(arr)
  return -1 if arr.empty?

  arr.each_index do |i|
    return i if i > 0 && arr[i] < arr[i - 1]
  end

  -1
end