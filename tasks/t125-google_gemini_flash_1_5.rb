def split_words(txt)
  if txt.include?(" ") || txt.include?(",")
    txt.split(/[\s,]/)
  else
    count = 0
    txt.downcase.each_char.with_index do |char, index|
      if char >= 'a' && char <= 'z' && (char.ord - 'a'.ord).odd?
        count += 1
      end
    end
    count
  end
end
