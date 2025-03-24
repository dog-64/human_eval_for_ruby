def largest_smallest_integers(lst)
  pos = lst.select(&:positive?).min
  neg = lst.select(&:negative?).max
  [neg, pos]
end