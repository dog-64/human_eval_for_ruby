def cycpattern_check(a, b)
  return false if b.length > a.length
  return true if b.empty?

  doubled_a = a + a
  doubled_a.include?(b)
end