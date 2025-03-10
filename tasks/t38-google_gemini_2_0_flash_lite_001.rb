def encode_cyclic(s)
  encoded = ""
  (0...s.length).step(3) do |i|
    group = s[i, 3]
    if group.length == 3
      encoded += group[1] + group[2] + group[0]
    else
      encoded += group
    end
  end
  encoded
end

def decode_cyclic(s)
  decoded = ""
  (0...s.length).step(3) do |i|
    group = s[i, 3]
    if group.length == 3
      decoded += group[2] + group[0] + group[1]
    else
      decoded += group
    end
  end
  decoded
end