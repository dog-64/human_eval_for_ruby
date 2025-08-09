def solve(s)
  has_letter = s.each_char.any? { |c| c =~ /\p{L}/ }
  return s.reverse unless has_letter
  s.each_char.map { |c| c =~ /\p{L}/ ? c.swapcase : c }.join
end