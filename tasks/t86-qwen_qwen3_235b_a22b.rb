

def anti_shuffle(s)
  s.scan(/\S+|\s+/).map do |token|
    token[0] == ' ' ? token : token.chars.sort.join
  end.join
end