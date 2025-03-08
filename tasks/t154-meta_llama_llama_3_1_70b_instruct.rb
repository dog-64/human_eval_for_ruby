def cycpattern_check(a, b)
  b.size.times do |i|
    return true if a.include?(b[i..-1] + b[0...i])
  end
  false
end