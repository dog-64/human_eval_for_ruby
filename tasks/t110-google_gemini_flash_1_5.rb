def exchange(lst1, lst2)
  odd_count = lst1.count { |x| x.odd? }
  even_count_lst2 = lst2.count { |x| x.even? }
  if odd_count <= even_count_lst2
    "YES"
  else
    "NO"
  end
end
