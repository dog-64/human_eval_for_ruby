def largest_smallest_integers(lst)
  largest_negative = lst.select { |x| x < 0 }.max
  smallest_positive = lst.select { |x| x > 0 }.min
  [largest_negative, smallest_positive]
end