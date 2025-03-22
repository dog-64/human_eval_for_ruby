def largest_smallest_integers(lst)
  negatives = lst.select { |x| x < 0 }.max
  positives = lst.select { |x| x > 0 }.min
  [negatives, positives]
end