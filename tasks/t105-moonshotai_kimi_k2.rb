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
  
  filtered = arr.select { |num| num >= 1 && num <= 9 }
  return [] if filtered.empty?
  
  sorted = filtered.sort.reverse
  reversed = sorted.reverse
  reversed.map { |num| number_words[num] }
end