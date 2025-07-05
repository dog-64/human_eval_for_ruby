def fix_spaces(text)
  result = ''
  prev_space = false
  text.each_char do |char|
    if char == ' '
      if prev_space
        result += '-'
      else
        result += '_'
      end
      prev_space = true
    else
      result += char
      prev_space = false
    end
  end
  result
end
