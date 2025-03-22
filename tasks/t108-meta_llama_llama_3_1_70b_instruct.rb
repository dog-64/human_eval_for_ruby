def count_nums(arr)
  arr.count do |num|
    num.abs.to_s.chars.map(&:to_i).sum > 0
  end
end