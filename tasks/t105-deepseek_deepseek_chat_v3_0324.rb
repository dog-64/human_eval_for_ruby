def by_length(arr)
  number_words = {
    1 => "One",
    2 => "Two",
    3 => "Three",
    4 => "Four",
    5 => "Five",
    6 => "Six",
    7 => "Seven",
    8 => "Eight",
    9 => "Nine"
  }

  filtered = arr.select { |num| num.between?(1, 9) }
  sorted = filtered.sort.reverse
  sorted.map { |num| number_words[num] }
end