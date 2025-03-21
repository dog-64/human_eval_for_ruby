def exchange(lst1, lst2)
  even_count = lst1.count(&:even?) + lst2.count(&:even?)
  odd_count = lst1.count(&:odd?) + lst2.count(&:odd?)
  even_count >= odd_count ? "YES" : "NO"
end