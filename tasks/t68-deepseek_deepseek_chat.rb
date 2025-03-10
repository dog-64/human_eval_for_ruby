def pluck(arr)
  evens = arr.each_with_index.select { |x, i| x.even? }
  return [] if evens.empty?
  min_even = evens.min_by { |x, i| x }
  [min_even[0], min_even[1]]
end