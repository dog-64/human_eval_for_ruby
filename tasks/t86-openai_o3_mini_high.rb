def anti_shuffle(s)
  s.gsub(/\S+/) { |word| word.chars.sort.join }
end