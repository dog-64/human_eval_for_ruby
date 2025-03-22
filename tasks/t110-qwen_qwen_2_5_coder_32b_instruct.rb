def exchange(lst1, lst2)
  lst1_odd = lst1.any? { |num| num.odd? }
  lst2_even = lst2.any? { |num| num.even? }
  
  lst1_odd && lst2_even ? "YES" : "NO"
end