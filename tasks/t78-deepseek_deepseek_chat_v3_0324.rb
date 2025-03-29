def hex_key(hex_string)
  primes = ['2', '3', '5', '7', 'B', 'D']
  hex_string.chars.count { |c| primes.include?(c) }
end