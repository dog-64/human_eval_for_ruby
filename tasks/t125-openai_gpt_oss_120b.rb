def split_words(txt)
  if txt.include?(' ')
    txt.split(' ')
  elsif txt.include?(',')
    txt.split(',')
  else
    txt.each_char.count { |c| ('a'..'z').include?(c) && ((c.ord - 'a'.ord) & 1 == 1) }
  end
end