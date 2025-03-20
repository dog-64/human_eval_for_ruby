def separate_paren_groups(s)
  result = []
  current_group = ''
  depth = 0
  
  s.each_char do |c|
    if c == '('
      depth += 1
      current_group += c
    elsif c == ')'
      depth -= 1
      current_group += c
      
      if depth == 0
        result << current_group.gsub(' ', '')
        current_group = ''
      elsif depth < 0
        return []
      end
    elsif depth > 0 && c != ' '
      current_group += c
    end
  end
  
  depth == 0 ? result : []
end 