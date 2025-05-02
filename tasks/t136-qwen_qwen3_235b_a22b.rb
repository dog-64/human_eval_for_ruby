def largest_smallest_integers(lst)
  negatives = lst.select { |x| x < 0 }
  positives = lst.select { |x| x > 0 }
  [negatives.max, positives.min]
end