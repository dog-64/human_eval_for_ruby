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

  arr.select { |num| num.is_a?(Integer) && num >= 1 && num <= 9 }
     .sort
     .reverse
     .map { |num| num_to_word[num] }
end
