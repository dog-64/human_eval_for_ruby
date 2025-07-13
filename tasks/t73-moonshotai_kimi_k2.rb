def smallest_change(arr)
  return 0 if arr.empty? || arr.length == 1
  
  left = 0
  right = arr.length - 1
  changes = 0
  
  while left < right
    changes += 1 if arr[left] != arr[right]
    left += 1
    right -= 1
  end
  
  changes
end