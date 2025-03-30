
def cycpattern_check(a, b)
  return true if b.empty? && a.empty?
  return false if b.empty? || a.empty?

  len_b = b.length
  len_a = a.length

  return false if len_b > len_a

  s = b + b

  len_sub = len_b

  a.each_char.with_index do |_, i|
    next unless i + len_sub <= len_a
    substr = a[i, len_sub]
    return true if s.include?(substr)
  end

  false
end

 