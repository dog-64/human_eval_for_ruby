def sort_array(arr)
  arr.sort_by { |x| [x < 0 ? Float::INFINITY : x.to_s(2).count('1'), x] }
end