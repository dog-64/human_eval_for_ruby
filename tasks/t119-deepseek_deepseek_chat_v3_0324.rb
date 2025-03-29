def match_parens(lst)
  s1, s2 = lst
  [s1 + s2, s2 + s1].any? { |s| balanced?(s) } ? 'Yes' : 'No'
end

def balanced?(s)
  balance = 0
  s.each_char do |c|
    balance += c == '(' ? 1 : -1
    return false if balance < 0
  end
  balance.zero?
end