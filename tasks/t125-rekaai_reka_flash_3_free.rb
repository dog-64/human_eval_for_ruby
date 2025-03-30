
def split_words(txt)
  if txt.include?(' ')
    txt.split(/\s+/)
  elsif txt.include?(',')
    txt.split(/,+/)
  else
    count = 0
    txt.each_char { |c| count += 1 if c =~ /[a-z]/ && (c.ord - 97).odd? }
    count
  end
end

 