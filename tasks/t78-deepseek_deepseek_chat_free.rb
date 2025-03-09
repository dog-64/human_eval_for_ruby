def hex_key(hex_string)
  primes = {'2' => true, '3' => true, '5' => true, '7' => true, 'B' => true, 'D' => true}
  hex_string.chars.count { |char| primes.key?(char) }
end
