def next_smallest(list)
  return nil if list.nil? || list.size < 2
  min = nil
  second = nil
  list.each do |x|
    if min.nil? || x < min
      second = min
      min = x
    elsif x != min && (second.nil? || x < second)
      second = x
    end
  end
  second
end