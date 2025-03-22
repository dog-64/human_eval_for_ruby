def separate_paren_groups(paren_string)
  result = []
  current_group = ''
  balance = 0

  paren_string.chars.each do |char|
    next if char == ' '

    current_group += char
    balance += 1 if char == '('
    balance -= 1 if char == ')'

    if balance == 0
      result << current_group
      current_group = ''
    end
  end

  result
end