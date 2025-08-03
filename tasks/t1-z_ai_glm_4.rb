
def separate_paren_groups(paren_string)
  cleaned = paren_string.gsub(' ', '')
  result = []
  current_group = ""
  balance = 0
  
  cleaned.each_char do |char|
    current_group += char
    if char == '('
      balance += 1
    elsif char == ')'
      balance -= 1
    end
    
    if balance == 0
      result << current_group
      current_group = ""
    end
  end
  
  result
end