def encode_cyclic(s)
  encoded = ""
  i = 0
  while i < s.length - 2
    encoded += s[i+1] + s[i+2] + s[i]
    i += 3
  end
  encoded += s[i..-1] if i < s.length
  encoded
end

def decode_cyclic(s)
  decoded = ""
  i = 0
  while i < s.length - 2
    decoded += s[i+2] + s[i] + s[i+1]
    i += 3
  end
  decoded += s[i..-1] if i < s.length
  decoded
end