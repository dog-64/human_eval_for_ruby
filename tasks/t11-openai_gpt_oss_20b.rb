def string_xor(a, b)
  min_len = [a.length, b.length].min
  (0...min_len).map { |i| a[i] == b[i] ? '0' : '1' }.join
end