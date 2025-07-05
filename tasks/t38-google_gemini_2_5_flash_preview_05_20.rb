def encode_cyclic(s)
  encoded_string = ""
  s.each_char.each_slice(3) do |slice|
    if slice.length == 3
      encoded_string << slice[1] << slice[2] << slice[0]
    else
      encoded_string << slice.join
    end
  end
  encoded_string
end

def decode_cyclic(s)
  decoded_string = ""
  s.each_char.each_slice(3) do |slice|
    if slice.length == 3
      decoded_string << slice[2] << slice[0] << slice[1]
    else
      decoded_string << slice.join
    end
  end
  decoded_string
end