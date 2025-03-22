def is_nested?(string)
  balance = 0
  nested = false

  string.each_char do |char|
    if char == '['
      balance += 1
    elsif char == ']'
      balance -= 1
    end

    if balance > 1
      nested = true
    end

    return false if balance < 0
  end

  nested && balance.zero?
end