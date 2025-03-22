def hex_key(hex_string)
  prime_hex_digits = %w[2 3 5 7 B D]
  hex_string.count { |char| prime_hex_digits.include?(char) }
end