def separate_paren_groups(paren_string)
  result = []
  current_group = ''
  balance = 0

  paren_string.each_char do |char|
    if char == '('
      balance += 1
      current_group += char
    elsif char == ')'
      balance -= 1
      current_group += char
    elsif balance == 0 && (char == ' ' || char == '')
      result << current_group
      current_group = ''
    end
  end

  result << current_group if current_group != ''
  result
end
