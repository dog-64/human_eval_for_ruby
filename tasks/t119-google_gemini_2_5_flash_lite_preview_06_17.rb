def match_parens(lst)
  def is_balanced?(str)
    balance = 0
    str.each_char do |char|
      if char == '('
        balance += 1
      elsif char == ')'
        balance -= 1
      end
      return false if balance < 0
    end
    balance == 0
  end

  str1, str2 = lst
  if is_balanced?(str1 + str2) || is_balanced?(str2 + str1)
    'Yes'
  else
    'No'
  end
end