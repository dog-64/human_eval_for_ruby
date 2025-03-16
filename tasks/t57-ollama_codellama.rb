def monotonic?(arr)
  return true if arr.empty? || arr.size == 1

  order = arr[0] <=> arr[1]
  (1...arr.size).each do |i|
    next if order == 0
    return false if arr[i - 1] <=> arr[i] != order
  end

  true
end