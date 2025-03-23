
def match_parens(lst)
  s1 = lst[0]
  s2 = lst[1]

  def is_good(s)
    balance = 0
    s.each_char do |c|
      if c == '('
        balance += 1
      elsif c == ')'
        balance -= 1
      end
      if balance < 0
        return false
      end
    end
    balance == 0
  end

  if is_good(s1 + s2) || is_good(s2 + s1)
    'Yes'
  else
    'No'
  end
end
