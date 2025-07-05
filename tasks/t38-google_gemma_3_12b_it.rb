def encode_cyclic(s)
  return "" if s.empty?
  encoded_string = ""
  (0...s.length).step(3) do |i|
    if i + 2 < s.length
      encoded_string += s[i+1]
      encoded_string += s[i]
      encoded_string += s[i+2]
    else
      encoded_string += s[i..-1]
    end
  end
  encoded_string
end

def decode_cyclic(s)
  return "" if s.empty?
  decoded_string = ""
  (0...s.length).step(3) do |i|
    if i + 2 < s.length
      decoded_string += s[i+1]
      decoded_string += s[i]
      decoded_string += s[i+2]
    else
      decoded_string += s[i..-1]
    end
  end
  decoded_string
end
