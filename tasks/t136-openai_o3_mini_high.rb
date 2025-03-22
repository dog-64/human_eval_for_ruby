def largest_smallest_integers(lst)
  negatives = lst.select { |n| n < 0 }
  positives = lst.select { |n| n > 0 }
  max_negative = negatives.empty? ? nil : negatives.max
  min_positive = positives.empty? ? nil : positives.min
  [max_negative, min_positive]
end