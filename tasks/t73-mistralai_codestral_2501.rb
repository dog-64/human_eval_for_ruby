def smallest_change(arr)
  return 0 if arr.empty?

  left, right = 0, arr.size - 1
  changes = 0

  while left < right
    if arr[left] != arr[right]
      changes += 1
    end
    left += 1
    right -= 1
  end

  changes
end