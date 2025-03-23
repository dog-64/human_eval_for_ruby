
def encode_cyclic(s)
  result = ""
  i = 0
  while i < s.length
    if i + 2 < s.length
      result += s[i+1] + s[i+2] + s[i]
      i += 3
    else
      result += s[i..-1]
      i = s.length
    end
  end
  result
end

def decode_cyclic(s)
  result = ""
  i = 0
  while i < s.length
    if i + 2 < s.length
      result += s[i+2] + s[i] + s[i+1]
      i += 3
    else
      result += s[i..-1]
      i = s.length
    end
  end
  result
end
