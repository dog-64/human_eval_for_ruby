def decode_shift(s)
  s.each_char.with_index do |char, index|
    if char =~ /[a-z]/
      shift = (char.ord - 'a'.ord + 5) % 26 + 'a'.ord
      s[index] = (char.ord - shift).chr
    end
  end
  s
end