def match_parens(lst)
  str1, str2 = lst
  return 'Yes' if valid?(str1 + str2) || valid?(str2 + str1)
  'No'
end

def valid?(str)
  balance = 0
  str.each_char do |char|
    balance += 1 if char == '('
    balance -= 1 if char == ')'
    return false if balance < 0
  end
  balance.zero?
end