def split_words(txt)
  if txt.include?(' ') || txt.include?(',')
    txt.split(/[\s,]+/)
  else
    count = 0
    txt.each_char do |char|
      if char.match?(/[a-z]/)
        if (char.ord - 'a'.ord) % 2 != 0
          count += 1
        end
      end
    end
    count
  end
end
