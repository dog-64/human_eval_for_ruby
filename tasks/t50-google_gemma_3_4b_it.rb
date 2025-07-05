def decode_shift(s)
  s.chars.map do |char|
    if ('a' <= char && char <= 'z')
      ('a' <= char ? 'a'.ord - 5 : 'z'.ord - 5)
    else
      char
    end
  end.join
end
