def cycpattern_check(a, b)
  return false if a.empty? || b.empty?

  a.length.times do |i|
    if a[i..-1] + a[0...i] == b
      return true
    end
  end

  false
end