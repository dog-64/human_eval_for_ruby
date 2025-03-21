def largest_smallest_integers(lst)
  negative = nil
  positive = nil

  lst.each do |num|
    if num < 0
      negative = num if negative.nil? || num > negative
    elsif num > 0
      positive = num if positive.nil? || num < positive
    end
  end

  return [negative, positive]
end