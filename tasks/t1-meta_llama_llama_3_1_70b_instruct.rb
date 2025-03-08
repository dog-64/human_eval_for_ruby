def separate_paren_groups(paren_string)
  paren_string = paren_string.gsub(' ', '')
  result = []
  stack = []
  temp = ''

  paren_string.each_char do |char|
    temp << char
    stack.push(char) if char == '('
    stack.pop if char == ')'
    if stack.empty? &&!temp.empty?
      result << temp
      temp = ''
    end
  end

  result
end