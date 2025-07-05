def smallest_change(arr)
  changes = 0
  left = 0
  right = arr.length - 1

  while left < right
    changes += 1 unless arr[left] == arr[right]
    left += 1
    right -= 1
  end

  changes
end