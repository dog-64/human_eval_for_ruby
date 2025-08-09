def count_nums(arr)
  arr.count do |n|
    digits = n.abs.to_s.chars.map(&:to_i)
    sum = digits.sum
    sum -= 2 * digits[0] if n < 0
    sum > 0
  end
end