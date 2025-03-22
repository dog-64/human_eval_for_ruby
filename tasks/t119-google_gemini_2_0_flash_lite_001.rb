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

def match_parens(lst)
  s1, s2 = lst
  if is_good(s1 + s2)
    'Yes'
  elsif is_good(s2 + s1)
    'Yes'
  else
    'No'
  end
end