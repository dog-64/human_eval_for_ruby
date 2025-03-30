
def largest_smallest_integers(lst)
  negative = lst.select { |n| n < 0 }
  a = negative.any? ? negative.max : nil

  positive = lst.select { |n| n > 0 }
  b = positive.any? ? positive.min : nil

  [a, b]
end

 