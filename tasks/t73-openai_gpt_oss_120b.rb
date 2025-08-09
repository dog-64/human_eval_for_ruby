def smallest_change(arr)
  count = 0
  i = 0
  j = arr.length - 1
  while i < j
    count += 1 if arr[i] != arr[j]
    i += 1
    j -= 1
  end
  count
end