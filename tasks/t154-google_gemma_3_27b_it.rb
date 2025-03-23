
def cycpattern_check(a, b)
  return false if a.empty? || b.empty?
  return true if a.include?(b)
  b_len = b.length
  (0...b_len).each do |i|
    rotated_b = b[i..-1] + b[0...i]
    return true if a.include?(rotated_b)
  end
  false
end
