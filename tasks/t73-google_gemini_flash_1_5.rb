def smallest_change(arr)
  return 0 if arr.empty? || arr.size == 1
  n = arr.size
  count = 0
  (n / 2).times do |i|
    count += 1 if arr[i] != arr[n - 1 - i]
  end
  count
end
