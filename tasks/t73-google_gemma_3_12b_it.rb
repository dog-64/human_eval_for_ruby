def smallest_change(arr)
  count = 0
  n = arr.length
  for i in 0...n/2
    if arr[i] != arr[n-1-i]
      count += 1
    end
  end
  count
end
