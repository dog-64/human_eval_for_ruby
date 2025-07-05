def pluck(arr)
  even_numbers_with_indices = arr.each_with_index.select { |num, index| num.even? }
  return [] if even_numbers_with_indices.empty?
  even_numbers_with_indices.min_by { |num, index| [num, index] }
end