def match_parens(lst)
  s1 = lst[0]
  s2 = lst[1]

  def is_balanced?(s)
    balance = 0
    s.each_char do |char|
      if char == '('
        balance += 1
      elsif char == ')'
        balance -= 1
      end
      return false if balance < 0
    end
    balance == 0
  end

  if is_balanced?(s1 + s2) || is_balanced?(s2 + s1)
    'Yes'
  else
    'No'
  end
end