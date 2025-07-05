def is_nested?(string)
  balance = 0
  nested = false
  string.each_char do |char|
    if char == '['
      balance += 1
    elsif char == ']'
      balance -= 1
    end
    if balance < 0
      nested = true
      break
    end
  end
  balance == 0 && nested
end
