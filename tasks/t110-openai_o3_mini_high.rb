def exchange(lst1, lst2)
  total_even = lst1.count(&:even?) + lst2.count(&:even?)
  total_even >= lst1.size ? "YES" : "NO"
end