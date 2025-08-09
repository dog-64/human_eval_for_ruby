def separate_paren_groups(paren_string)
  result = []
  buffer = ''
  depth = 0
  paren_string.each_char do |ch|
    next if ch == ' '
    if ch == '('
      buffer << ch
      depth += 1
    elsif ch == ')'
      if depth > 0
        buffer << ch
        depth -= 1
        if depth == 0
          result << buffer
          buffer = ''
        end
      else
        # stray closing parenthesis, ignore
        next
      end
    end
  end
  result
end