def by_length(arr)
  mapping = {
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
  arr.select { |n| n >= 1 && n <= 9 }
     .sort { |a, b| b <=> a }
     .map { |n| mapping[n] }
end