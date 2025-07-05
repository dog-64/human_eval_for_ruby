def by_length(arr)
  filtered_arr = arr.filter { |num| num >= 1 && num <= 9 }
  sorted_arr = filtered_arr.sort.reverse
  word_array = sorted_arr.map { |num|
    case num
    when 1 then "One"
    when 2 then "Two"
    when 3 then "Three"
    when 4 then "Four"
    when 5 then "Five"
    when 6 then "Six"
    when 7 then "Seven"
    when 8 then "Eight"
    when 9 then "Nine"
    end
  }
  word_array
end
