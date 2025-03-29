def split_words(txt)
  words = txt.split(/[\s,]+/)
  if words.empty?
    txt.length.ord.odd? ? 0 : txt.length
  else
    words
  end
end