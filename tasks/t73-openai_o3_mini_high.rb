def smallest_change(arr)
  count = 0
  n = arr.size
  (0...n/2).each { |i| count += 1 if arr[i] != arr[n - 1 - i] }
  count
end