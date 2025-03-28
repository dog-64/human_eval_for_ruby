def cycpattern_check(a, b)
  return false if b.empty?
  return true if a.empty? && b.empty?

  doubled_b = b * 2
  (0...b.length).any? { |i| a.include?(doubled_b[i, b.length]) }
end