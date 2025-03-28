def separate_paren_groups(paren_string)
  result = []
  current_group = []
  balance = 0

  paren_string.chars.each do |char|
    next if char == ' '

    if char == '('
      balance += 1
      current_group << char
    elsif char == ')'
      balance -= 1
      current_group << char
      if balance == 0
        result << current_group.join
        current_group = []
      end
    end
  end

  result
end