def cycpattern_check(a, b)
  return false if a.empty? || b.empty?
  a.size <= b.size and b.size.times do |i|
    return true if a[i...a.size] == b[0...b.size-i]
  end
  false
end