def separate_paren_groups(paren_string)
  result = []
  stack = 0
  current_group = ''
  
  paren_string.gsub(' ', '').each_char do |char|
    if char == '('
      stack += 1
      current_group += char
    elsif char == ')'
      stack -= 1
      current_group += char
      if stack == 0
        result << current_group
        current_group = ''
      end
    end
  end
  
  result
end