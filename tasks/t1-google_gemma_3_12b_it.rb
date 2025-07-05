def separate_paren_groups(paren_string)
  paren_string.gsub(/\s+/, '').split(/(?=\()/).reject(&:empty?).map do |group|
    balance = 0
    start = 0
    end_index = -1

    group.each_char.with_index do |char, index|
      if char == '('
        balance += 1
      elsif char == ')'
        balance -= 1
      end

      if balance == 0
        end_index = index
        break
      end
    end

    if end_index != -1
      group[start..end_index]
    else
      ''
    end
  end.compact
end
