def encode_cyclic(s)
  s.each_slice(3).map { |slice| slice.rotate(1) }.join
end

def decode_cyclic(s)
  s.each_slice(3).map { |slice| slice.rotate(-1) }.join
end