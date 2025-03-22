def count_nums(arr)
  arr.count { |num| num.to_s.chars.each_with_index.sum { |char, i| i.zero? && char == '-' ? -char.next.to_i : char.to_i } > 0 }
end