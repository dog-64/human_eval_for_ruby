def separate_paren_groups(paren_string)
  stack = []
  result = []
  paren_string.gsub!(/(\s+|\(|\))/, '')
  while true
    if paren_string.empty?
      break
    end
    if paren_string[0] == '('
      stack << paren_string[0]
      paren_string = paren_string[1..-1]
    elsif paren_string[0] == ')'
      if stack.empty?
        result << paren_string
        paren_string = ''
      else
        stack.pop
        paren_string = paren_string[1..-1]
      end
    else
      paren_string = paren_string[1..-1]
    end
  end
  result
end