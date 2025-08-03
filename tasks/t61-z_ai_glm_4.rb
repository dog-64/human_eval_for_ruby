
correct_bracketing(brackets)
  balance = 0
  brackets.each_char do |char|
    if char == '('
      balance += 1
    elsif char == ')'
      balance -= 1
      return false if balance < 0
    end
  end
  balance == 0
end