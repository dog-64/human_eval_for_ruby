def correct_bracketing(brackets)
  balance = 0
  brackets.each_char do |ch|
    if ch == '<'
      balance += 1
    elsif ch == '>'
      balance -= 1
      return false if balance < 0
    end
  end
  balance.zero?
end