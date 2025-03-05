def count_nums(arr)
  arr.count { |num|
    digits = num.to_s.chars
    sum = digits[0] == '-' ? -digits[1].to_i : digits[0].to_i
    sum += digits[1..-1].map(&:to_i).sum if digits.size > 1
    sum > 0
  }
end