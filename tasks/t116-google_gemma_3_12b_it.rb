def sort_array(arr)
  arr.sort_by { |num| [num.to_s(2).count('1'), num] }.reject { |num| num < 0 }
end
