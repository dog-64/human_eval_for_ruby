def encode_cyclic(s)
  result = ""
  s.each_char do |c|
    if c == 'a'
      result += 'b'
    elsif c == 'b'
      result += 'c'
    else
      result += 'a'
    end
  end
  return result
end

def decode_cyclic(s)
  result = ""
  s.each_char do |c|
    if c == 'b'
      result += 'a'
    elsif c == 'c'
      result += 'b'
    else
      result += 'c'
    end
  end
  return result
end