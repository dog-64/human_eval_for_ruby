def match_parens(lst)
  s1, s2 = lst
  [s1 + s2, s2 + s1].each do |s|
    balance = 0
    s.chars.each do |c|
      balance += (c == '(' ? 1 : -1)
      break if balance < 0
    end
    return 'Yes' if balance == 0
  end
  'No'
end