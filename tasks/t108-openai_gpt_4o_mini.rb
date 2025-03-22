def count_nums(arr)
  arr.count { |num| num.to_s.chars.map(&:to_i).sum - (num < 0 ? 1 : 0) > 0 }
end