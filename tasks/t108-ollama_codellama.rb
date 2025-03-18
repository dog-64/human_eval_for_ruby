def count_nums(arr)
  arr.count { |num| num > 0 || (num < 0 && num.abs.to_s.sum > 0) }
end