def match_parens(lst)
  str1 = lst[0]
  str2 = lst[1]

  def is_good(s)
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

  if is_good(str1 + str2)
    'Yes'
  elsif is_good(str2 + str1)
    'Yes'
  else
    'No'
  end
end
