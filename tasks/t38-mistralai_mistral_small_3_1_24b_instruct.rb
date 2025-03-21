def encode_cyclic(s)
  s.chars.each_slice(3).map { |group| group.rotate(-1) }.join
end

def decode_cyclic(s)
  s.chars.each_slice(3).map { |group| group.rotate(1) }.join
end