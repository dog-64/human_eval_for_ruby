

def hex_key(hex_string)
  primes = ['2', '3', '5', '7', 'B', 'D']
  count = 0
  hex_string.each_char { |c| count += 1 if primes.include?(c) }
  count
end