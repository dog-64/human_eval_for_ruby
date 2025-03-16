def cycpattern_check(a, b)
  return a.include?(b) if b.empty?
  (0...b.size).each do |i|
    return true if a.include?(b[i..-1] + b[0...i])
  end
  false
end