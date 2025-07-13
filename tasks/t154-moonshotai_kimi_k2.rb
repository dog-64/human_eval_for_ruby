def cycpattern_check(a, b)
  return true if b.empty?
  return false if b.length > a.length
  
  doubled_b = b + b
  (0...b.length).any? { |i| a.include?(doubled_b[i, b.length]) }
end