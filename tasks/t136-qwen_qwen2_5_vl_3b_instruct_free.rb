def largest_smallest_integers(lst)
  negatives = lst.select { |num| num < 0 }
  positives = lst.select { |num| num > 0 }
  
  largest_negative = negatives.max
  smallest_positive = positives.min
  
  [largest_negative, smallest_positive]
end
