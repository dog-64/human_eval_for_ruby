def hex_key(hex_string)
  primes = [2, 3, 5, 7]
  primes << 'B' if hex_string.include?('B')
  primes << 'D' if hex_string.include?('D')

  count = 0
  primes.each do |prime|
    count += 1 if hex_string.include?(prime)
  end

  count
end