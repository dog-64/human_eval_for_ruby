def correct_bracketing(brackets)
  balance = 0
  brackets.each_char do |char|
    if char == '<'
      balance += 1
    elsif char == '>'
      balance -= 1
    else
      return false
    end
    return false if balance < 0
  end
  balance.zero?
end