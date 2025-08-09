def largest_smallest_integers(lst)
  largest_neg = nil
  smallest_pos = nil
  lst.each do |n|
    if n < 0
      largest_neg = n if largest_neg.nil? || n > largest_neg
    elsif n > 0
      smallest_pos = n if smallest_pos.nil? || n < smallest_pos
    end
  end
  [largest_neg, smallest_pos]
end