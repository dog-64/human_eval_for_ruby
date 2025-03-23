def smallest_change(arr)
  n = arr.length
  count = 0
  i = 0
  while i < n / 2
    if arr[i] != arr[n - 1 - i]
      count += 1
    end
    i += 1
  end
  count
end