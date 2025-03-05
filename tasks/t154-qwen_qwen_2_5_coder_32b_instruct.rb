def cycpattern_check(a, b)
  return false if b.length > a.length
  doubled_b = b + b
  doubled_b.include?(a)
end