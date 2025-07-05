def by_length(arr)
  filtered_arr = arr.select { |num| num >= 1 && num <= 9 }
  sorted_arr = filtered_arr.sort.reverse
  string_arr = sorted_arr.map { |num| num.to_s }
  string_arr
end
