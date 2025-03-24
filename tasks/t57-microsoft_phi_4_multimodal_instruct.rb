def monotonic?(arr)
  return true if arr.length <= 1
  ascending = descending = true

  (1..arr.length - 1).each do |i|
    if arr[i] > arr[i - 1]
      descending = false
    elsif arr[i] < arr[i - 1]
      ascending = false
    end
  end

  ascending || descending
end