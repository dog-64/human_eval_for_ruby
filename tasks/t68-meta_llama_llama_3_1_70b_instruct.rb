def pluck(arr)
  arr.each_with_index.filter { |x, _| x.even? }.min_by { |x, _| x } || []
end