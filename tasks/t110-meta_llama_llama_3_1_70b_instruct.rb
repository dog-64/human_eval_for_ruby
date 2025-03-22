def exchange(lst1, lst2)
  lst1.select(&:odd?).size <= lst2.select(&:even?).size ? "YES" : "NO"
end