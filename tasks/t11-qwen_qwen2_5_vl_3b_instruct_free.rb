def string_xor(a, b)
  a.zip(b) { |x, y| x ^ y }
end
