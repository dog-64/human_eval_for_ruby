def largest_smallest_integers(lst)
  negative = lst.select { |x| x < 0 }.max
  positive = lst.select { |x| x > 0 }.min
  [negative, positive]
end