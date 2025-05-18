def cycpattern_check(a, b)
  return false if b.length > a.length
  (b + b).include?(a)
end