def hex_key(hex_string)
  prime_hex = ['2', '3', '5', '7', 'B', 'D']
  hex_string.each_char.count { |char| prime_hex.include?(char) }
end