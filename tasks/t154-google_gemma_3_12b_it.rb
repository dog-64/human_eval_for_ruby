def cycpattern_check(a, b)
  return false if b.empty? && !a.empty?
  return true if a.empty? && b.empty?
  return false if b.length > a.length
  
  (0...b.length).each do |i|
    rotated_b = b[i..-1] + b[0...i]
    return true if a.include?(rotated_b)
  end
  
  false
end
