def anti_shuffle(s)
  s.split.map(&:chars.sort.join).join(' ')
end