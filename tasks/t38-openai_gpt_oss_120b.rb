def encode_cyclic(s)
  return s if s.length < 3
  first = s[0, 3]
  rest = s[3..-1] || ""
  encoded_first = first[1] + first[2] + first[0]
  encoded_rest = rest.length % 3 == 0 ? rest : rest[1..-1] + rest[0]
  encoded_first + encoded_rest
end

def decode_cyclic(s)
  return s if s.length < 3
  first = s[0, 3]
  rest = s[3..-1] || ""
  decoded_first = first[2] + first[0] + first[1]
  decoded_rest = rest.length % 3 == 0 ? rest : rest[-1] + rest[0...-1]
  decoded_first + decoded_rest
end