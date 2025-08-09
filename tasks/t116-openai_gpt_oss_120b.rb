def sort_array(arr)
  return arr.sort if arr.any? { |x| x < 0 }
  arr.sort_by { |x| [x.to_s(2).count('1'), x] }
end