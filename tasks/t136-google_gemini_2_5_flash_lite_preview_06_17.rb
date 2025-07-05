def largest_smallest_integers(lst)
  negative_numbers = lst.select { |n| n < 0 }
  positive_numbers = lst.select { |n| n > 0 }

  largest_negative = negative_numbers.empty? ? nil : negative_numbers.max
  smallest_positive = positive_numbers.empty? ? nil : positive_numbers.min

  [largest_negative, smallest_positive]
end