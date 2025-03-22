def hex_key(hex_string)
  primes = [2, 3, 5, 7, 11, 13]
  count = 0
  hex_string.each_char do |char|
    if char >= '0' && char <= '9'
      num = char.to_i
      count += 1 if primes.include?(num)
    elsif char >= 'A' && char <= 'F'
      num = char.ord - 'A'.ord + 10
      count += 1 if primes.include?(num)
    end
  end
  count
end
