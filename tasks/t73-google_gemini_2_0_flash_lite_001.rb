def smallest_change(arr)
  return 0 if arr.empty? || arr.length == 1

  changes = 0
  left = 0
  right = arr.length - 1

  while left < right
    if arr[left] != arr[right]
      changes += 1
    end
    left += 1
    right -= 1
  end

  changes
end