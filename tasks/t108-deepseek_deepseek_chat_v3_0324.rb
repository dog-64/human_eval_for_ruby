def count_nums(arr)
  arr.count do |num|
    digits = num.abs.to_s.chars.map(&:to_i)
    sum = digits.sum
    sum = -digits.first + digits[1..-1].sum if num < 0
    sum > 0
  end
end