def exchange(lst1, lst2)
  odd_in_lst1 = lst1.select { |num| num.odd? }
  even_in_lst2 = lst2.select { |num| num.even? }

  if odd_in_lst1.size <= even_in_lst2.size
    "YES"
  else
    "NO"
  end
end