def encode_cyclic(s)
  s.chars.each_slice(3).map(&:rotate).join
end

def decode_cyclic(s)
  s.chars.each_slice(3).map(&:rotate(-1)).join
end