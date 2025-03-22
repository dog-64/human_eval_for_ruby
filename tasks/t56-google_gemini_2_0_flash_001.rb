def correct_bracketing(brackets)
  balance = 0
  for bracket in brackets.chars
    if bracket == '<'
      balance += 1
    elsif bracket == '>'
      balance -= 1
    else
      return false
    end
    if balance < 0
      return false
    end
  end
  return balance == 0
end