def pluck(arr)
  even_values = arr.each_with_index.select { |value, index| value.even? }
  return [] if even_values.empty?
  even_values.min_by { |value, index| [value, index] }
end