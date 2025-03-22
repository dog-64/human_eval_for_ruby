def separate_paren_groups(paren_string)
  paren_string.delete(' ').chars.each_with_object([]) do |char, result|
    if char == '('
      (result.last ||= '') << char
    elsif char == ')' && result.any?
      group = result.last << char
      if group.count('(') == group.count(')')
        result[-1] = result.pop
      end
    end
  end
end