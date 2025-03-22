def pluck(arr)
  even_numbers = arr.each_with_index.select { |num, _| num.even? }
  return [] if even_numbers.empty?
  
  even_numbers.min_by { |num, index| [num, index] }
end