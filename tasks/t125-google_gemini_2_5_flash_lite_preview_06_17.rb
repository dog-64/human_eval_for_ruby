def split_words(txt)
  if txt.include?(' ') || txt.include?(',')
    txt.split(/[\s,]/).reject(&:empty?)
  else
    txt.downcase.each_char.with_index.count do |char, index|
      char.match?(/[a-z]/) && (char.ord - 'a'.ord).odd?
    end
  end
end