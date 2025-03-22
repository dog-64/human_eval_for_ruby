def encode_cyclic(s)
  return s if s.size < 3
  prefix = s[0, 3]
  encoded_prefix = prefix[1] + prefix[2] + prefix[0]
  remainder = s.size > 3 ? s[3..-1] : ""
  encoded_prefix + remainder
end

def decode_cyclic(s)
  return s if s.size < 3
  prefix = s[0, 3]
  decoded_prefix = prefix[2] + prefix[0] + prefix[1]
  remainder = s.size > 3 ? s[3..-1] : ""
  decoded_prefix + remainder
end