def exchange(lst1, lst2)
  odds_in_lst1 = lst1.count { |x| x.odd? }
  evens_in_lst2 = lst2.count { |x| x.even? }
  odds_in_lst1 <= evens_in_lst2 ? "YES" : "NO"
end


# Вторая реализация, без использования метода count
def exchange(lst1, lst2)
  odds_in_lst1 = lst1.select { |x| x.odd? }.size
  evens_in_lst2 = lst2.select { |x| x.even? }.size
  odds_in_lst1 <= evens_in_lst2 ? "YES" : "NO"
end