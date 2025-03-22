def pluck(arr)
  min_even = Float::INFINITY
  min_index = -1
  arr.each_with_index do |x, i|
    if x.even? && x < min_even
      min_even = x
      min_index = i
    end
  end
  return [min_even, min_index] if min_even != Float::INFINITY
  []
end