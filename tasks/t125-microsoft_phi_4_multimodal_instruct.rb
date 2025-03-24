def split_words(txt)
  if txt.include?(' ') || txt.include?(',')
    txt.split(/[\s,]+/)
  else
    txt.count_characters.with_index(1) { |char, index| char == char.downcase && index.odd? }.count
  end
end