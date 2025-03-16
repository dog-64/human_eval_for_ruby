def largest_smallest_integers(lst)
  negative = nil
  positive = nil

  lst.each do |num|
    if num < 0 && (negative.nil? || num > negative)
      negative = num
    elsif num > 0 && (positive.nil? || num < positive)
      positive = num
    end
  end

  return [negative, positive]
end