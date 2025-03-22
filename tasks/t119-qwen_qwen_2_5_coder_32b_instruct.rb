def match_parens(lst)
  a, b = lst
  return 'Yes' if balanced?(a + b) || balanced?(b + a)
  'No'
end

def balanced?(s)
  balance = 0
  s.each_char do |char|
    balance += char == '(' ? 1 : -1
    return false if balance < 0
  end
  balance == 0
end