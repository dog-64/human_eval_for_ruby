def split_words(txt)
  if txt.include?(' ') || txt.include?(',')
    txt.split(/[ ,]/).reject(&:empty?)
  else
    count = 0
    txt.each_char do |c|
      if c.match?(/[a-z]/)
        pos = c.ord - 'a'.ord
        count += 1 if pos.odd?
      end
    end
    count
  end
end