def separate_paren_groups(paren_string)
  stack = []
  result = []
  current_group = ''

  paren_string.each_char do |char|
    next if char == ' '

    current_group << char

    if char == '('
      stack.push(char)
    elsif char == ')'
      stack.pop
    end

    if stack.empty? && !current_group.empty?
      result << current_group
      current_group = ''
    end
  end

  result
end