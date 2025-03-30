
def anti_shuffle(s)
  tokens = s.scan(/(\S+|\s+)/)
  tokens.map { |token| token.match?(/\S/) ? token.chars.sort.join : token }.join
end

 