def separate_paren_groups(paren_string)
  groups = []
  current = ""
  balance = 0
  
  paren_string.each_char do |char|
    next if char == ' '
    
    current += char
    
    if char == '('
      balance += 1
    elsif char == ')'
      balance -= 1
    end
    
    if balance == 0 && !current.empty?
      groups << current
      current = ""
    end
  end
  
  groups
end