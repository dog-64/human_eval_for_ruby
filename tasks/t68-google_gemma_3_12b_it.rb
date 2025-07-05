def pluck(arr)
  even_numbers = arr.select { |num| num.even? }
  
  if even_numbers.empty?
    []
  else
    min_even = even_numbers.min
    index = arr.index(min_even)
    [min_even, index]
  end
end
