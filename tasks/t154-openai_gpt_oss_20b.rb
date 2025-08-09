def cycpattern_check(a, b)
  return true if b.empty?
  return false if a.empty?
  len = b.length
  (0...len).each do |i|
    shift = b[i..-1] + b[0...i]
    return true if a.include?(shift)
  end
  false
end