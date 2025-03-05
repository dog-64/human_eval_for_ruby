def cycpattern_check(a, b)
  return false if a.nil? || b.nil?
  return true if a.empty? && b.empty?
  return false if a.empty? && !b.empty?
  return b.empty? if !a.empty? && b.empty?

  (0...b.length).each do |i|
    rotated_b = b[i..-1] + b[0...i]
    return true if a.include?(rotated_b)
  end
  false
end