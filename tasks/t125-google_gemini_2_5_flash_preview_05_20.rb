def split_words(txt)
  if txt.include?(' ')
    txt.split(' ')
  elsif txt.include?(',')
    txt.split(',')
  else
    count = 0
    txt.each_char do |char|
      if char.match?(/[a-z]/)
        if (char.ord - 'a'.ord).odd?
          count += 1
        end
      end
    end
    count
  end
end