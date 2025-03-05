def hex_key(hex_string)
  count = 0
  primes = ['2', '3', '5', '7', 'B', 'D']
  hex_string.each_char do |char|
    if primes.include?(char)
      count += 1
    end
  end
  count
end