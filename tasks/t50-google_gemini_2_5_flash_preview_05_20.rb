def decode_shift(s)
  s.chars.map do |char|
    if char.match?(/[a-z]/)
      ((char.ord - 'a'.ord - 5 + 26) % 26 + 'a'.ord).chr
    else
      char
    end
  end.join
end