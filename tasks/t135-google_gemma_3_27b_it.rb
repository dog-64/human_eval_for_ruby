def can_arrange(arr)
  return -1 if arr.empty?

  last_index = -1
  for i in 1...arr.length
    if arr[i] < arr[i - 1]
      last_index = i
    end
  end

  return last_index
end