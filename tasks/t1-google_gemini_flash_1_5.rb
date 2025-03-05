def separate_paren_groups(paren_string)
  paren_string.gsub!(/\s/, '')
  return [] if paren_string.empty?

  result = []
  count = 0
  start = 0
  paren_string.each_char.with_index do |char, i|
    if char == '('
      count += 1
    elsif char == ')'
      count -= 1
    end
    if count == 0 && i > start
      result << paren_string[start..i]
      start = i + 1
    end
  end
  result
end
