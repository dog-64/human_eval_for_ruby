def exchange(lst1, lst2)
  odd_in_lst1 = lst1.count(&:odd?)
  even_in_lst2 = lst2.count(&:even?)
  odd_in_lst1 <= even_in_lst2 ? "YES" : "NO"
end