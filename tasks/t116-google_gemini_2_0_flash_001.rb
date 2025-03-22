def sort_array(arr)
  arr.sort_by { |x| [x.negative? ? 0 : x.to_s(2).count('1'), x] }
end