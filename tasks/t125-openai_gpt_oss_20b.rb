def split_words(txt)
  if txt.include?(' ') || txt.include?(',')
    words = txt.split(/[ ,]+/)
    words.reject!(&:empty?)
    words
  else
    txt.scan(/[bdfhjlnprtvxz]/).size
  end
end