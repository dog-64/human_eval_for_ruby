def largest_smallest_integers(lst)
  negatives = lst.select { |n| n < 0 }
  positives = lst.select { |n| n > 0 }
  
  largest_negative = negatives.empty? ? nil : negatives.max
  smallest_positive = positives.empty? ? nil : positives.min
  
  [largest_negative, smallest_positive]
end