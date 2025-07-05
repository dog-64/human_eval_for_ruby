def encrypt(s)
  result = ''
  s.each_char do |char|
    position = char.ord - ord('a') + 1
    shifted_position = position * 2
    shifted_char = (shifted_position - 1) % 26 + ord('a')
    result += shifted_char.chr
  end
  result
end
