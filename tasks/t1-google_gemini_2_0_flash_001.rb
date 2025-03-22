def separate_paren_groups(paren_string)
  result = []
  current_group = ""
  balance = 0

  paren_string.gsub(/\s+/, "").each_char do |char|
    if char == '('
      balance += 1
      current_group += char
    elsif char == ')'
      balance -= 1
      current_group += char
    end

    if balance == 0 && !current_group.empty?
      result << current_group
      current_group = ""
    end
  end

  return result
end