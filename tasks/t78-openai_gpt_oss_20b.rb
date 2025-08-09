def hex_key(hex_string)
  prime_digits = ['2', '3', '5', '7', 'B', 'D']
  hex_string.chars.count { |c| prime_digits.include?(c) }
end