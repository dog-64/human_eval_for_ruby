
def by_length(arr)
  filtered = arr.select { |x| x >= 1 && x <= 9 }
  sorted_asc = filtered.sort
  reversed = sorted_asc.reverse
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
  reversed.map { |num| words[num] }
end