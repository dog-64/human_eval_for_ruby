def count_nums(arr)
  arr.count do |num|
    digits = num.to_s.chars.map(&:to_i)
    digits[0] = -digits[0] if num < 0
    digits.sum > 0
  end
end