def exchange(lst1, lst2)
  odd_count = lst1.count { |num| num.odd? }
  even_count_in_lst2 = lst2.count { |num| num.even? }
  odd_count <= even_count_in_lst2 ? "YES" : "NO"
end