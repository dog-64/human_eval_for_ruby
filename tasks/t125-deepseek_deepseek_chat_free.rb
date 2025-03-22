def split_words(txt)
  if txt.match?(/[ ,]/)
    txt.split(/[ ,]+/)
  else
    txt.chars.count { |c| c.match?(/[a-z]/) && (c.ord - 'a'.ord).odd? }
  end
end