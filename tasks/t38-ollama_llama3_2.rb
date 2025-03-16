def encode_cyclic(s)
  s.chars.each_slice(3).map { |a, b, c| [c, a, b].join }.join
end

def decode_cyclic(s)
  s.chars.each_slice(3).map { |a, b, c| [b, c, a].join }.join
end