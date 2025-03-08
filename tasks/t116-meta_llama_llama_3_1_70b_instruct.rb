def sort_array(arr)
  arr.select { |x| x >= 0 }.sort_by { |x| [x.to_s(2).count('1'), x] }
end