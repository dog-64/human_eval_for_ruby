
def match_parens(lst)
  s1, s2 = lst
  
  def balanced?(str)
    balance = 0
    str.each_char do |c|
      balance += (c == '(' ? 1 : -1)
      return false if balance < 0
    end
    balance == 0
  end
  
  return 'Yes' if balanced?(s1 + s2)
  return 'Yes' if balanced?(s2 + s1)
  
  'No'
end