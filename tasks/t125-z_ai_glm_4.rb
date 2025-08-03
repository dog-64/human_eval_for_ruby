
def split_words(txt)
  if txt.include?(' ')
    txt.split
  elsif txt.include?(',')
    txt.split(',')
  else
    count = 0
    txt.each_char do |c|
      if c >= 'a' && c <= 'z'
        pos = c.ord - 'a'.ord
        count += 1 if pos.odd?
      end
    end
    count
  end
end