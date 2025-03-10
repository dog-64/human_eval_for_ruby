def hex_key(hex_string)
  prime_hex_digits = {
    "2" => true,
    "3" => true,
    "5" => true,
    "7" => true,
    "B" => true,
    "D" => true
  }
  count = 0
  hex_string.each_char do |char|
    if prime_hex_digits[char]
      count += 1
    end
  end
  count
end