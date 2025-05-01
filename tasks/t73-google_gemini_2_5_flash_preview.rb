def smallest_change(arr)
  changes = 0
  n = arr.length
  (0...n / 2).each do |i|
    changes += 1 if arr[i] != arr[n - 1 - i]
  end
  changes
end