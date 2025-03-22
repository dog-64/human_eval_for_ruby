def exchange(lst1, lst2)
  odd_count_lst1 = lst1.count { |x| x.odd? }
  even_count_lst2 = lst2.count { |x| x.even? }
  odd_count_lst1 <= even_count_lst2 ? "YES" : "NO"
end