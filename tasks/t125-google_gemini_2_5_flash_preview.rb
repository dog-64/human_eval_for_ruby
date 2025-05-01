def split_words(txt)
  if txt.include?(' ')
    txt.split(' ')
  elsif txt.include?(',')
    txt.split(',')
  else
    txt.each_char.count do |char|
      if char.match?(/[a-z]/)
        (char.ord - 'a'.ord).odd?
      else
        false
      end
    end
  end
end