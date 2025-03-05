def can_arrange(arr)
  (arr.size - 1).downto(1) do |i|
    return i if arr[i] < arr[i - 1]
  end
  -1
end