def can_arrange(arr)
  arr.each_with_index do |current, index|
    return index if current < arr[index - 1]
  end
  -1
end
