def encode_cyclic(s)
  encoded_s = ""
  s.chars.each_slice(3) do |group|
    if group.length == 3
      encoded_s += group[1] + group[2] + group[0]
    else
      encoded_s += group.join
    end
  end
  encoded_s
end

def decode_cyclic(s)
  decoded_s = ""
  s.chars.each_slice(3) do |group|
    if group.length == 3
      decoded_s += group[2] + group[0] + group[1]
    else
      decoded_s += group.join
    end
  end
  decoded_s
end
