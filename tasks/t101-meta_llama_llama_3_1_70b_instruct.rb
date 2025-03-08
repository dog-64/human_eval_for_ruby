def words_string(s)
  s.gsub(',', ' ').split.map(&:strip).reject(&:empty?)
end