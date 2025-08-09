def correct_bracketing(brackets)
  balance = 0
  brackets.each_char do |ch|
    case ch
    when '('
      balance += 1
    when ')'
      balance -= 1
      return false if balance < 0
    end
  end
  balance.zero?
end