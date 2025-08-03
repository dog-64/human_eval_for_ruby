

def total_match(lst1, lst2)
  total1 = lst1.sum { |s| s.length }
  total2 = lst2.sum { |s| s.length }
  total1 <= total2 ? lst1 : lst2
end