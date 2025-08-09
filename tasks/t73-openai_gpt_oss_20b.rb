def smallest_change(arr)
  n = arr.length
  changes = 0
  (0...(n / 2)).each do |i|
    changes += 1 if arr[i] != arr[n - 1 - i]
  end
  changes
end