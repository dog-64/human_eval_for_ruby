def smallest_change(arr)
  n = arr.length
  changes = 0
  for i in 0...n / 2
    if arr[i] != arr[n - 1 - i]
      changes += 1
    end
  end
  changes
end
