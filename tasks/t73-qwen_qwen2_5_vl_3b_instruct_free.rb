def smallest_change(arr)
  n = arr.length
  left = 0
  right = n - 1
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