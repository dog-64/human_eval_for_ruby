def exchange(lst1, lst2)
  (lst1 + lst2).count(&:even?) == lst1.size
end