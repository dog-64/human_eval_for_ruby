def count_nums(arr)
  arr.sum { |num| sum_digits(num) > 0 }
end

def sum_digits(num)
  digits = num.abs.to_s.chars.map(&:to_i)
  digits.reduce(0, :+)
end
