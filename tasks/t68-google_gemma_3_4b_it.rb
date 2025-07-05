def pluck(arr)
  min_even = Float::INFINITY
  min_index = -1

  (0...arr.length).each do |i|
    if arr[i] % 2 == 0
      if arr[i] < min_even
        min_even = arr[i]
        min_index = i
      end
    end
  end

  if min_index == -1
    []
  else
    [min_even, min_index]
  end
end
