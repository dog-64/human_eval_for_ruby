def cycpattern_check(a, b)
  m = b.length
  return true if m == 0
  return false if m > a.length
  doubled = b + b
  (0..a.length - m).each do |i|
    return true if doubled.include?(a[i, m])
  end
  false
end