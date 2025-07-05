def words_string(s)
  s.split(/[, ]+/).reject(&:empty?)
end
