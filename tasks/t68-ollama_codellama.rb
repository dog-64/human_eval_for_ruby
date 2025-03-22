def pluck(arr)
  return [] if arr.empty?

  min_even = arr.min_by { |x| x % 2 == 0 ? x : Float::INFINITY }

  [min_even, arr.index(min_even)]
end