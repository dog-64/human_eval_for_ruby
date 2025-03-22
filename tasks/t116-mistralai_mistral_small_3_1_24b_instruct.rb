def sort_array(arr)
  arr.sort_by { |num| [num.bit_length, num] }
end