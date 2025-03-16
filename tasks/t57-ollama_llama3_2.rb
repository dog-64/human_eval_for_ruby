def monotonic?(arr)
  return true if arr.empty?
  prev = arr.first
  arr.each do |curr|
    return false if curr < prev
    prev = curr
  end
  true
end