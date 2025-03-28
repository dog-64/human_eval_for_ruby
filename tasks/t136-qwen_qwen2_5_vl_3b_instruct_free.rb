def largest_smallest_integers(lst)
  negative = lst.select { |num| num < 0 }.max
  positive = lst.select { |num| num > 0 }.min
  [negative, positive]
end