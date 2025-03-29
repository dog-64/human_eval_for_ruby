def can_arrange(arr)
  return -1 if arr.empty?

  arr.each_with_index do |current, index|
    if index > 0 && current < arr[index - 1]
      return index
    end
  end

  -1
end