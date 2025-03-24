def pluck(arr)
  even_index = arr.index { |num| num.even? }
  return [arr[even_index], even_index] if even_index
end
