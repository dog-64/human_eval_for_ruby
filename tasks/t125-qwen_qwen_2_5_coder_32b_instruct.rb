def split_words(txt)
  if txt.include?(' ') || txt.include?(',')
    txt.split(/[\s,]+/)
  else
    txt.chars.count { |c| c =~ /[a-z]/ && (c.ord - 'a'.ord).odd? }
  end
end