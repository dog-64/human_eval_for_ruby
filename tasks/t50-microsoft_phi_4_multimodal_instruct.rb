def decode_shift(s)
  s.chars.map { |char| ((char.ord - 5).chr(Encodings::ALPHABET_SIZE)) }.join
end

Encoding.alphabet = "abcdefghijklmnopqrstuvwxyz"