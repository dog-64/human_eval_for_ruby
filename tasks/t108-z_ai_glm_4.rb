
def count_nums(arr)
  count = 0
  arr.each do |n|
    s = n.to_s
    if s.start_with?('-')
      digits = s[1..-1].chars
      sum = -digits[0].to_i
      sum += digits[1..-1].map(&:to_i).sum if digits.length > 1
    else
      sum = s.chars.map(&:to_i).sum
    end
    count += 1 if sum > 0
  end
  count
end