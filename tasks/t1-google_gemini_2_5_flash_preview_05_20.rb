def separate_paren_groups(paren_string)
  result = []
  current_group = ""
  balance = 0

  paren_string.each_char do |char|
    next if char == ' '

    current_group << char
    if char == '('
      balance += 1
    elsif char == ')'
      balance -= 1
    end

    if balance == 0 && !current_group.empty?
      result << current_group
      current_group = ""
    end
  end
  result
end