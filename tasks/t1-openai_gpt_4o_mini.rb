def separate_paren_groups(paren_string)
  paren_string = paren_string.gsub(' ', '')
  groups = []
  stack = []
  current_group = ''

  paren_string.each_char do |char|
    if char == '('
      if stack.empty?
        current_group = ''
      end
      stack.push(char)
      current_group << char
    elsif char == ')'
      if stack.empty?
        next
      end
      stack.pop
      current_group << char
      if stack.empty?
        groups << current_group
      end
    end
  end

  groups
end