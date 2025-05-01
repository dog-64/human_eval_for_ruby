def hex_key(hex_string)
  prime_hex_digits = ['2', '3', '5', '7', 'B', 'D']
  count = 0
  hex_string.each_char do |char|
    count += 1 if prime_hex_digits.include?(char)
  end
  count
end