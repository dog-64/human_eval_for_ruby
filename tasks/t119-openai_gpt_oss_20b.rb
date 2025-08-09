def match_parens(lst)
  s, t = lst
  bal = 0
  min_s = 0
  s.each_char do |c|
    bal_s += (c == '(' ? 1 : -1)
    min_s = [min_s, bal_s].min
  end
  bal_t = 0
  min_t = 0
  t.each_char do |c|
    bal_t += (c == '(' ? 1 : -1)
    min_t = [min_t, bal_t].min
  end
  ok1 = (bal_s + bal_t == 0) && (min_s >= 0) && (min_t + bal_s >= 0)
  ok2 = (bal_s + bal_t == 0) && (min_t >= 0) && (min_s + bal_t >= 0)
  ok1 || ok2 ? 'Yes' : 'No'
end