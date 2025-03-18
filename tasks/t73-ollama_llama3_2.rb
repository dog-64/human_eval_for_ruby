def smallest_change(arr)
  return 0 if arr.empty?
  mid = arr.size / 2
  left, right = 0, arr.size - 1
  changes = 0
  while left < mid && arr[left] == arr[mid]
    left += 1
    mid -= 1
  end
  while left < mid || right >= mid
    if arr[left] != arr[right]
      changes += 1
    end
    left += 1
    right -= 1
  end
  changes
end