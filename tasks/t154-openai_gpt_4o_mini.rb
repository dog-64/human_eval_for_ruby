def cycpattern_check(a, b)
  return false if b.length > a.length
  (a + a).include?(b)
end