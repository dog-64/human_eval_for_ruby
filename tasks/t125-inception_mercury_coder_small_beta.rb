def split_words(txt)
  if txt.include?(' ') || txt.include?(',')
    txt.split(/[\s,]+/)
  else
    txt.chars.select { |char| char.match?(/[a-z]/) && (char.ord - 'a'.ord) % 2 != 0 }.count
  end
end