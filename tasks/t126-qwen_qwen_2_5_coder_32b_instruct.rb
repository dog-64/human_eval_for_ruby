def is_sorted?(lst)
  return true if lst.empty?
  lst == lst.uniq && lst == lst.sort
end