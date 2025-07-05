def is_sorted?(lst)
  return true if lst.empty?
  lst.each_cons(2).all? { |a, b| a <= b } && lst.uniq.length == lst.length
end