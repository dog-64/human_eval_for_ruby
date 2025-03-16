def split_words(txt)
  if txt.include?(" ")
    txt.split
  elsif txt.include?(",")
    txt.split(",")
  else
    count = 0
    txt.each_char do |ch|
      if ch >= "a" && ch <= "z" && (ch.ord - "a".ord) % 2 == 1
        count += 1
      end
    end
    count
  end
end