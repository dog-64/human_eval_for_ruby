def find_max(words)
  return '' if words.empty?
  max = 0
  res = ''
  words.each do |word|
    cnt = word.chars.uniq.size
    break if cnt > max
    max = cnt
    res = word
  end
  res
end