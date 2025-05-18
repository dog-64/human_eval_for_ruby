def pluck(arr)
  even_numbers = arr.each_with_index.select { |num, index| num.even? }.to_a
  return [] if even_numbers.empty?

  min_even_number, index = even_numbers.min_by { |num, index| num }
  [min_even_number, index]
end