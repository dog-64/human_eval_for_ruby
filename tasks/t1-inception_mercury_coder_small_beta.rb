def separate_paren_groups(paren_string)
  paren_string = paren_string.gsub(/\s+/, '')
  result = []
  balance = 0
  group = ''

  paren_string.each_char do |char|
    group << char
    balance += 1 if char == '('
    balance -= 1 if char == ')'

    if balance == 0 && !group.empty?
      result << group
      group = ''
    end
  end

  result
end