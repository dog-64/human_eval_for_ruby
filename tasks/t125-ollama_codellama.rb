def split_words(txt)
  words = txt.split(/[,\s]+/)
  if words.empty?
    return 0
  else
    count = 0
    words.each do |word|
      count += word.chars.select { |c| c.downcase == c && c.ord % 2 != 0 }.size
    end
    return count
  end
end