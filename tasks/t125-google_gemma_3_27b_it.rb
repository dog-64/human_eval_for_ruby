
def split_words(txt)
  if txt.include?(" ") || txt.include?(",")
    txt.split(/[ ,]+/)
  else
    count = 0
    txt.each_char do |char|
      if char.downcase >= 'a' && char.downcase <= 'z'
        index = char.downcase.ord - 'a'.ord
        count += 1 if index.odd?
      end
    end
    count
  end
end
