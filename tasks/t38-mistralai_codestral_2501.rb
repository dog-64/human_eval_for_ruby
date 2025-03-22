def encode_cyclic(s)
  result = ""
  i = 0
  while i < s.length
    if i + 3 <= s.length
      group = s[i, 3]
      result += group[1, 2] + group[0]
    else
      result += s[i, s.length - i]
    end
    i += 3
  end
  result
end

def decode_cyclic(s)
  result = ""
  i = 0
  while i < s.length
    if i + 3 <= s.length
      group = s[i, 3]
      result += group[2] + group[0, 2]
    else
      result += s[i, s.length - i]
    end
    i += 3
  end
  result
end