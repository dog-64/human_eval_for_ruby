def exchange(lst1, lst2)
  odd_count_lst1 = lst1.count(&:odd?)
  even_count_lst2 = lst2.count(&:even?)

  if odd_count_lst1 <= even_count_lst2
    "YES"
  else
    "NO"
  end
end
