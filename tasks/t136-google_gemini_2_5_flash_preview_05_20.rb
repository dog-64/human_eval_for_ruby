def largest_smallest_integers(lst)
  largest_negative = nil
  smallest_positive = nil

  lst.each do |num|
    if num < 0
      largest_negative = num if largest_negative.nil? || num > largest_negative
    elsif num > 0
      smallest_positive = num if smallest_positive.nil? || num < smallest_positive
    end
  end

  [largest_negative, smallest_positive]
end