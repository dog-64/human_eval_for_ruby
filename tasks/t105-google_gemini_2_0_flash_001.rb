def by_length(arr)
  word_map = {
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

  filtered_arr = arr.select { |num| num >= 1 && num <= 9 }
  sorted_arr = filtered_arr.sort
  reversed_arr = sorted_arr.reverse

  reversed_arr.map { |num| word_map[num] }
end