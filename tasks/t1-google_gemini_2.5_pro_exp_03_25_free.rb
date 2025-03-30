def separate_paren_groups(paren_string)
  cleaned_string = paren_string.gsub(/\s+/, '')
  result = []
  balance = 0
  start_index = nil

  cleaned_string.each_char.with_index do |char, index|
    if char == '('
      start_index = index if balance == 0
      balance += 1
    elsif char == ')'
      balance -= 1
      if balance == 0 && !start_index.nil?
        result << cleaned_string[start_index..index]
        start_index = nil
      elsif balance < 0
        # Reset if balance goes negative (invalid sequence)
        balance = 0
        start_index = nil
      end
    end
  end

  result
end
