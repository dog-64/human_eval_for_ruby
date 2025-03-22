def cycpattern_check(a, b)
  return false if b.empty?
  return a.include?(b) if a.length < b.length
  b_length = b.length
  (a.length - b_length + 1).times do |i|
    substring = a[i, b_length]
    b_length.times do |j|
      rotated = b[j..-1] + b[0...j]
      return true if substring == rotated
    end
  end
  false
end