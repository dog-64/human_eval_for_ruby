def count_nums(arr)
  arr.count { |x| x.to_s.chars.map(&:to_i).sum > 0 }
end