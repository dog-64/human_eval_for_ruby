def digit_sum(s)
  s.chars.reduce(0) { |sum, char| char =~ /[A-Z]/ ? sum + char.ord : sum }
end