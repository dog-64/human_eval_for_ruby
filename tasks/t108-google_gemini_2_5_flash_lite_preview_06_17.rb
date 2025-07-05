def sum_digits(n)
  s = n.to_s
  if n < 0
    -s[0].to_i + s[1..-1].chars.map(&:to_i).sum
  else
    s.chars.map(&:to_i).sum
  end
end

def count_nums(arr)
  arr.count { |num| sum_digits(num) > 0 }
end