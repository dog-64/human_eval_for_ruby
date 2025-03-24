def count_nums(arr)
  arr.count { |num| num.to_s.chars.map(&:digits).inject(:+) > 0 }
end