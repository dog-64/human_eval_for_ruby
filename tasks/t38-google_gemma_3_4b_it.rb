def encode_cyclic(s)
  s.chars.each_slice(3).map(&:shift).join
end

def decode_cyclic(s)
  s.chars.each_slice(3).map(&:pop).join
end
