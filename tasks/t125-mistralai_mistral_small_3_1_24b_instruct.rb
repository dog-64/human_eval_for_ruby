def split_words(txt)
  if txt.include?(' ') || txt.include?(',')
    txt.split(/[,\s]+/)
  else
    txt.count { |char| char =~ /[a-z]/ && (char.ord - 'a'.ord).odd? }
  end
end