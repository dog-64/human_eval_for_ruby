def correct_bracketing(brackets)
  balance = 0
  brackets.each_char do |bracket|
    if bracket == '('
      balance += 1
    elsif bracket == ')'
      balance -= 1
    end
    return false if balance < 0
  end
  balance == 0
end