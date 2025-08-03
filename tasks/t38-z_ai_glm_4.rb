
def encode_cyclic(s)
  return s if s.length < 3
  first_group = s[0..2]
  shifted_group = first_group.chars.rotate(1).join
  rest = s[3..-1] || ''
  shifted_group + rest
end

def decode_cyclic(s)
  return s if s.length < 3
  first_group = s[0..2]
  shifted_group = first_group.chars.rotate(-1).join
  rest = s[3..-1] || ''
  shifted_group + rest
end