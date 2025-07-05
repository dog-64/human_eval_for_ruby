def string_xor(a, b)
  [a, b].transpose.map { |char_a, char_b| char_a == char_b ? '0' : '1' }.join
end