def split_words(txt)
  return 0 if txt.empty?

  if txt.include?(' ') || txt.include?(',')
    txt.split(/[\s,]+/)
  else
    txt.chars.select { |char| char =~ /[a-z]/ }.count { |char| (char.ord - 'a'.ord) % 2 == 1 }
  end
end