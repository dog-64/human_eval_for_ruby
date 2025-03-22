def sort_array(arr)
  arr.sort_by { |x| [x >= 0 ? x.to_s(2).count('1') : 0, x] }
end