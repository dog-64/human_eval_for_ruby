def largest_smallest_integers(lst)
  a = nil
  b = nil
  lst.each do |x|
    if x < 0 && (a.nil? || x > a)
      a = x
    elsif x > 0 && (b.nil? || x < b)
      b = x
    end
  end
  [a, b]