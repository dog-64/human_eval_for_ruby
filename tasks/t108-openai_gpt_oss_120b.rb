def sum_digits_with_sign(num)
  sign = num < 0 ? -1 : 1
  digits = num.abs.to_s.chars.map { |c| c.ord - 48 }
  sum = 0
  digits.each_with_index do |d, i|
    sum += i.zero? ? d * sign : d
  end
  sum
end

def count_nums(arr)
  arr.count { |n| sum_digits_with_sign(n) > 0 }
end