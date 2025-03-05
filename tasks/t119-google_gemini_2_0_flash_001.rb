def match_parens(lst)
  s1, s2 = lst
  
  def is_balanced?(s)
    balance = 0
    s.each_char do |c|
      if c == '('
        balance += 1
      elsif c == ')'
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