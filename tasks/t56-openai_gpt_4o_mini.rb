def correct_bracketing(brackets)
  balance = 0
  brackets.each_char do |char|
    return false if char != '<' && char != '>'
    balance += 1 if char == '<'
    balance -= 1 if char == '>'
    return false if balance < 0
  end
  balance.zero?
end