def split_words(txt)
  if txt.include?(' ') || txt.include?(',')
    txt.gsub(',', ' ').split
  else
    txt.count { |c| c =~ /[a-z]/ && c.ord.odd? }
  end
end