def smallest_change(arr)
  count = 0
  len = arr.length
  (0...len/2).each do |i|
    count += 1 if arr[i] != arr[-i-1]
  end
  count
end