def count_nums(arr)
  arr.count do |num|
    if num == 0
      false
    else
      digits = num.abs.to_s.chars.map(&:to_i)
      if num < 0
        sum = -digits[0] + digits[1..-1].sum
      else
        sum = digits.sum
      end
      sum > 0
    end
  end
end