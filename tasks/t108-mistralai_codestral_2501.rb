def count_nums(arr)
  arr.count { |num| num.to_s.chars.map(&:to_i).sum > 0 }
end