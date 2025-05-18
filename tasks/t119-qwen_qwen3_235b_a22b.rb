

def match_parens(lst)
  s1, s2 = lst
  [s1 + s2, s2 + s1].each do |combined|
    balance = 0
    valid = true
    combined.each_char do |c|
      balance += c == '(' ? 1 : -1
      valid = false if balance < 0
    end
    return 'Yes' if valid && balance == 0
  end
  'No'
end