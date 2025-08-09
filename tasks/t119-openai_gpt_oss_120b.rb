def balanced?(s)
  bal = 0
  s.each_char do |ch|
    bal += ch == '(' ? 1 : -1
    return false if bal < 0
  end
  bal == 0
end

def match_parens(lst)
  s1, s2 = lst
  balanced?(s1 + s2) || balanced?(s2 + s1) ? 'Yes' : 'No'
end