def monotonic?(arr)
  return true if arr.length <= 1
  inc = true
  dec = true
  (1...arr.length).each do |i|
    inc = false if arr[i] < arr[i - 1]
    dec = false if arr[i] > arr[i - 1]
    break unless inc || dec
  end
  inc || dec
end