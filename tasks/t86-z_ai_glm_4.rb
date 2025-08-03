
anti_shuffle(s)
  tokens = s.split(/( +)/)
  tokens.map do |token|
    if token.strip.empty?
      token
    else
      token.chars.sort.join
    end
  end.join
end