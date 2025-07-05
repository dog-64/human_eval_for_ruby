def by_length(arr)
  num_to_word = {
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

  arr.filter { |n| n.is_a?(Integer) && n >= 1 && n <= 9 }
     .sort
     .reverse
     .map { |n| num_to_word[n] }
end