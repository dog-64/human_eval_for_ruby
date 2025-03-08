def smallest_change(arr)
  l = 0
  r = arr.size - 1
  res = 0
  while l < r
    if arr[l] != arr[r]
      res += 1
    end
    l += 1
    r -= 1
  end
  res
end