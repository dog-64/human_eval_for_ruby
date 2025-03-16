def exchange(lst1, lst2)
  even_count = lst1.count { |x| x.even? }
  odd_count = lst1.count { |x| x.odd? }

  even_in_lst2 = lst2.count { |x| x.even? }
  odd_in_lst2 = lst2.count { |x| x.odd? }

  if even_in_lst2 >= odd_count
    "YES"
  else
    "NO"
  end
end