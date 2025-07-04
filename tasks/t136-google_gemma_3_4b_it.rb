def largest_smallest_integers(lst)
  negative_numbers = lst.select { |num| num < 0 }
  positive_numbers = lst.select { |num| num > 0 }

  largest_negative = negative_numbers.max? || nil
  smallest_positive = positive_numbers.min? || nil

  [largest_negative, smallest_positive]
end
