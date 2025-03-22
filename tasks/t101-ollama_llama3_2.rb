def words_string(s)
  s.gsub!(/,\s*/, ' ')
  s.gsub!(/\s+/, ' ')
  s.split
end