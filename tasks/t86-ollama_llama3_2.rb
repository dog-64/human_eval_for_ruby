def anti_shuffle(s)
  s.gsub(/\s+/, ' ').scan(/[a-zA-Z]/).sort.join(' ')
end