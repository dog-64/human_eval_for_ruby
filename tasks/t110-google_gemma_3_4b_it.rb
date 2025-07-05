def exchange(lst1, lst2)
  even_lst2 = lst2.select { |num| num.even? }
  odd_lst2 = lst2.select { |num| num.odd? }

  lst1.select! { |num| num.even? }

  if lst1.all? { |num| num.even? }
    "YES"
  else
    "NO"
  end
end
