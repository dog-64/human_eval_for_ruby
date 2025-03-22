def intersperse(numbers, delimiter)
  numbers.flat_map.with_index { |n, i| i.even?? n : [delimiter, n] }[0..-2]
end