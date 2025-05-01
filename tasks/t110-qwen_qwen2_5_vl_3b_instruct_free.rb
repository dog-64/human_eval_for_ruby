def exchange(lst1, lst2)
  even_count = lst1.count { |num| num.even? }
  odd_count = lst2.count { |num| num.odd? }
  
  return "YES" if even_count >= odd_count
  return "NO"
end
