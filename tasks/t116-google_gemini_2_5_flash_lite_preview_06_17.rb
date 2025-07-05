def sort_array(arr)
  arr.sort_by { |n| [n.to_s(2).count('1'), n] }
end