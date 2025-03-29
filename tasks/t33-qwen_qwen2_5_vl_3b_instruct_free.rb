def sort_third(l)
  sorted_thirds = l[::3].sort
  l.zip(sorted_thirds).map { |_, x| x }.uniq
end