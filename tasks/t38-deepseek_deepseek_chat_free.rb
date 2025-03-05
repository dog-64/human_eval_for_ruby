def encode_cyclic(s)
  s.chars.each_slice(3).map do |slice|
    if slice.length == 3
      slice.rotate
    else
      slice
    end
  end.flatten.join
end

def decode_cyclic(s)
  s.chars.each_slice(3).map do |slice|
    if slice.length == 3
      slice.rotate(-1)
    else
      slice
    end
  end.flatten.join
end