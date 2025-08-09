def anti_shuffle(s)
  tokens = s.scan(/[^ ]+| +/)
  tokens.map! do |token|
    if token.strip.empty?
      token
    else
      token.chars.sort.join
    end
  end
  tokens.join
end