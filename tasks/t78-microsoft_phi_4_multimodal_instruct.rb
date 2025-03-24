def hex_key(hex_string)
  simple_hex_primes = ['2', '3', '5', '7', 'B', 'D']
  hex_string.count { |char| simple_hex_primes.include?(char) }
end