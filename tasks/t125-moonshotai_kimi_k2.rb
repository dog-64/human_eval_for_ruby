def split_words(txt)
  if txt.include?(' ')
    txt.split(' ')
  elsif txt.include?(',')
    txt.split(',')
  else
    txt.chars.select { |c| c >= 'a' && c <= 'z' && (c.ord - 'a'.ord).odd? }.count
  end
end