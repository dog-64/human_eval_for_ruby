def match_parens(lst)
  left, right = lst
  left_balance, right_balance = left.scan(/()/.to_a).count('()'), right.scan(/()/.to_a).count('()')
  (left_balance + right_balance) % 2 == 0 && left_balance > 0 && right_balance > 0
end