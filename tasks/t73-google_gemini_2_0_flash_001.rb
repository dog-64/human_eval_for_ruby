def smallest_change(arr)
  count = 0
  left = 0
  right = arr.length - 1

  while left < right
    if arr[left] != arr[right]
      count += 1
    end
    left += 1
    right -= 1
  end

  count
end