def pluck(arr)
  evens = arr.each_with_index.select { |num, _| num.even? }
  return [] if evens.empty?
  min_even = evens.min_by { |num, _| num }
  [min_even[0], min_even[1]]
end