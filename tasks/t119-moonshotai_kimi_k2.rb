def match_parens(lst)
  str1, str2 = lst
  [str1 + str2, str2 + str1].any? { |s| balanced?(s) } ? 'Yes' : 'No'
end

def balanced?(str)
  balance = 0
  str.each_char do |char|
    balance += char == '(' ? 1 : -1
    return false if balance.negative?
  end
  balance.zero?
end