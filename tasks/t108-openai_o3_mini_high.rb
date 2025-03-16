def count_nums(arr)
  arr.count do |num|
    digits = num.abs.to_s.chars.map(&:to_i)
    sum = if num < 0
      -digits.first + digits[1..-1].to_a.sum
    else
      digits.sum
    end
    sum > 0
  end
end