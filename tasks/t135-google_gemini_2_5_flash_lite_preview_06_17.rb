def can_arrange(arr)
  return -1 if arr.empty?
  (1...arr.length).reverse_each do |i|
    return i if arr[i] < arr[i - 1]
  end
  -1
end