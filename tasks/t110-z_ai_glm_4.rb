
def exchange(lst1, lst2)
  odd_count1 = lst1.count { |x| x.odd? }
  even_count2 = lst2.count { |x| x.even? }
  odd_count1 <= even_count2 ? "YES" : "NO"
end