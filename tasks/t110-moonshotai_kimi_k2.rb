def exchange(lst1, lst2)
  odd_count = lst1.count { |x| x.odd? }
  even_count = lst2.count { |x| x.even? }
  odd_count <= even_count ? "YES" : "NO"
end