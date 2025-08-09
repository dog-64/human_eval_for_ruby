def encode_cyclic(s)
  result = +""
  i = 0
  while i < s.length
    chunk = s[i, 3]
    if chunk.length == 3
      result << chunk[1, 2] + chunk[0]
    else
      result << chunk
    end
    i += 3
  end
  result
end

def decode_cyclic(s)
  result = +""
  i = 0
  while i < s.length
    chunk = s[i, 3]
    if chunk.length == 3
      result << chunk[2] + chunk[0, 2]
    else
      result << chunk
    end
    i += 3
  end
  result
end