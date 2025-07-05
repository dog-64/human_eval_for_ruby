def words_string(s)
  s.split(/[,\s]+/).reject(&:empty?)
end
