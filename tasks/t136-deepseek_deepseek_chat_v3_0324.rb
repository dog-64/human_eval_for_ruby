def largest_smallest_integers(lst)
  negatives = lst.select { |x| x < 0 }
  positives = lst.select { |x| x > 0 }

  max_neg = negatives.empty? ? nil : negatives.max
  min_pos = positives.empty? ? nil : positives.min

  [max_neg, min_pos]
end