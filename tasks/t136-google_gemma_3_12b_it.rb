def largest_smallest_integers(lst)
  negatives = lst.select { |x| x < 0 }
  positives = lst.select { |x| x > 0 }

  largest_negative = negatives.max
  smallest_positive = positives.min

  [largest_negative, smallest_positive]
end
