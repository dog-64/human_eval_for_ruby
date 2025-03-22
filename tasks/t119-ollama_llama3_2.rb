def match_parens(lst)
  a, b = lst
  return 'Yes' if a.empty? || b.empty?
  return 'No' if (a + b).count('(') != (a + b).count(')')
  return 'Yes' if a.count('(') == a.count(')')
  return 'Yes' if b.count('(') == b.count(')')
  return 'Yes' if a.count(')') == a.count('(')
  return 'Yes' if b.count(')') == b.count('(')
  'No'
end