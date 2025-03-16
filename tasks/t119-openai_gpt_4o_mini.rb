def match_parens(lst)
  a, b = lst
  balance_a = a.chars.reduce(0) { |balance, char| balance + (char == '(' ? 1 : -1) }
  balance_b = b.chars.reduce(0) { |balance, char| balance + (char == '(' ? 1 : -1) }
  
  min_balance_a = a.chars.reduce(0) { |min_balance, char| 
    min_balance = [min_balance, (min_balance += char == '(' ? 1 : -1)].min 
  }
  
  min_balance_b = b.chars.reduce(0) { |min_balance, char| 
    min_balance = [min_balance, (min_balance += char == '(' ? 1 : -1)].min 
  }

  (balance_a + balance_b == 0) && (min_balance_a + balance_b >= 0) && (min_balance_b >= 0) ? 'Yes' : 'No'
end