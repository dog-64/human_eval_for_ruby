def encode_cyclic(s)
  s.chars.each_slice(3).map { |slice| slice.length == 3 ? slice.rotate(-1) : slice }.join
end

def decode_cyclic(s)
  s.chars.each_slice(3).map { |slice| slice.length == 3 ? slice.rotate(1) : slice }.join
end