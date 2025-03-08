def encode_cyclic(s)
  s.scan(/.{1,3}/).map { |g| g.chars.rotate(-1).join }.join
end

def decode_cyclic(s)
  s.scan(/.{1,3}/).map { |g| g.chars.rotate(1).join }.join
end