
def hex_key(hex_string)
  prime_digits = %w[2 3 5 7 B D]
  hex_string.each_char.with_object(0) { |c, acc| acc += 1 if prime_digits.include?(c) }
end

 