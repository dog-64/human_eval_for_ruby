def by_length(arr)
  numbers = arr.select { |x| x.between?(1, 9) }
  sorted = numbers.sort.reverse
  words = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
  sorted.map { |x| words[x - 1] }
end