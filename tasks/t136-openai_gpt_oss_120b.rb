def largest_smallest_integers(lst)
  max_neg = nil
  min_pos = nil
  lst.each do |n|
    if n < 0
      max_neg = n if max_neg.nil? || n > max_neg
    elsif n > 0
      min_pos = n if min_pos.nil? || n < min_pos
    end
  end
  [max_neg, min_pos]
end