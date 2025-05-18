def largest_smallest_integers(lst)
  negative_integers = lst.select { |num| num < 0 }
  positive_integers = lst.select { |num| num > 0 }

  largest_negative = negative_integers.any? ? negative_integers.max : nil
  smallest_positive = positive_integers.any? ? positive_integers.min : nil

  [largest_negative, smallest_positive]
end