def is_nested?(string)
  return false if string.empty?

  balance = 0
  nested = false

  string.each_char do |char|
    if char == '['
      balance += 1
      if balance > 1 && !nested
        nested = true
      end
    elsif char == ']'
      balance -= 1
      if balance < 0
        return false
      end
    end
  end

  return balance == 0 && nested
end