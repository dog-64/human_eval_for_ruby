def cycpattern_check(a, b)
  return false if b.empty?
  b_length = b.length
  b_doubled = b + b
  (0...b_length).each do |i|
    substring = b_doubled[i, b_length]
    return true if a.include?(substring)
  end
  false
end