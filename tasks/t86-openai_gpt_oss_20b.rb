def anti_shuffle(s)
  result = +""
  s.scan(/(\S+)|(\s+)/) do |word, space|
    if word
      result << word.chars.sort.join
    else
      result << space
    end
  end
  result
end