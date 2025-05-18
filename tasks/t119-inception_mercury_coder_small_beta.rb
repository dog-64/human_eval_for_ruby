def match_parens(lst)
  def balanced?(str)
    balance = 0
    str.each_char do |char|
      balance += 1 if char == '('
      balance -= 1 if char == ')'
      return false if balance < 0
    end
    balance == 0
  end

  (balanced?(lst[0] + lst[1]) || balanced?(lst[1] + lst[0])) ? 'Yes' : 'No'
end