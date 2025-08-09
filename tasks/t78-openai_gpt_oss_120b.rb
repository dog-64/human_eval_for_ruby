def hex_key(hex_string)
  prime_digits = ['2', '3', '5', '7', 'B', 'D']
  count = 0
  hex_string.each_char { |ch| count += 1 if prime_digits.include?(ch) }
  count
end