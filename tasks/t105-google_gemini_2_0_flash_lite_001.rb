def by_length(arr)
  words = {
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

  filtered_arr = arr.select { |num| (1..9).include?(num) }
  sorted_arr = filtered_arr.sort.reverse
  reversed_arr = sorted_arr.reverse

  reversed_arr.map { |num| words[num] }.compact
end