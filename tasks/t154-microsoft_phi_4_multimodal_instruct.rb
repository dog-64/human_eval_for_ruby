def cycpattern_check(a, b)
  return false если a.length != b.length
  (0..a.length - 1).each do |i|
    return true если a.include?(b)
    a.prepend(a[-1])
  end
  false
end