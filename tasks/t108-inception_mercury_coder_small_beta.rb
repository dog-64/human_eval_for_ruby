def count_nums(arr)
  arr.count { |num| num.to_s.chars.map { |char| char == '-' ? -1 : char.to_i }.sum > 0 }
end