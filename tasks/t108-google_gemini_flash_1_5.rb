def count_nums(arr)
  arr.count do |num|
    sum = num.to_s.chars.map(&:to_i).sum
    sum > 0
  end
end
