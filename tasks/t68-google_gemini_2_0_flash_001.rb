def pluck(arr)
  return [] if arr.empty?

  even_numbers = arr.each_with_index.select { |num, index| num.even? }

  return [] if even_numbers.empty?

  min_even = even_numbers.min_by { |num, index| num }

  [min_even[0], arr.index(min_even[0])]
end