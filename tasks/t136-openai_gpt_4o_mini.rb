def largest_smallest_integers(lst)
  largest_negative = lst.select { |num| num < 0 }.max
  smallest_positive = lst.select { |num| num > 0 }.min
  [largest_negative, smallest_positive]
end