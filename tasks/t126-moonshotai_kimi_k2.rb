def is_sorted?(lst)
  return true if lst.empty?
  
  counts = Hash.new(0)
  lst.each { |num| counts[num] += 1 }
  return false if counts.values.any? { |count| count > 2 }
  
  lst == lst.sort
end