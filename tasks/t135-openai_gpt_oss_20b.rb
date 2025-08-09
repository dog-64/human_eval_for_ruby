def can_arrange(arr)
  last_index = -1
  arr.each_with_index do |value, index|
    next if index.zero?
    last_index = index if value < arr[index - 1]
  end
  last_index
end