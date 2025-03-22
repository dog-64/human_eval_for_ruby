def cycpattern_check(a, b)
  return false if b.empty?

  b_length = b.length
  b_concat = b + b[0...-1]

  (0...b_length).each do |i|
    return true if a.include?(b_concat[i...i + b_length])
  end

  false
end