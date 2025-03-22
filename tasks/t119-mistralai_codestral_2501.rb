def match_parens(lst)
  def balanced?(s)
    balance = 0
    s.each_char do |char|
      balance += 1 if char == '('
      balance -= 1 if char == ')'
      return false if balance < 0
    end
    balance == 0
  end

  s1, s2 = lst
  balanced?(s1 + s2) || balanced?(s2 + s1) ? 'Yes' : 'No'
end