def count_nums(arr)
  arr.count do |num|
    digits = num.abs.digits.reverse
    digits[0] = -digits[0] if num.negative?
    digits.sum > 0
  end
end