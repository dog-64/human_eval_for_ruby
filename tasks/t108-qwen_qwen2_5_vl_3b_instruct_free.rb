def count_nums(arr)
  arr.sum { |num| num.abs.sum > 0 }
end