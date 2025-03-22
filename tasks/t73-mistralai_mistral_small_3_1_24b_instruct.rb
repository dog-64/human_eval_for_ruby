def smallest_change(arr)
  n = arr.length
  return 0 if n <= 1

  changes = 0
  (n / 2).times do |i|
    changes += 1 if arr[i] != arr[n - i - 1]
  end
  changes
end