def split_words(txt)
  if txt.include?(" ") || txt.include?(",")
    txt.split(/[ ,]+/)
  else
    count = 0
    txt.each_char.with_index do |char, index|
      if ('a'..'z').include?(char) && (char.ord - 'a'.ord) % 2 != 0
        count += 1
      end
    end
    count
  end
end