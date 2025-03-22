def is_sorted?(lst)
  return true if lst.empty?
  
  counts = Hash.new(0)
  
  (0...lst.length - 1).each do |i|
    if lst[i] > lst[i+1]
      return false
    end
    counts[lst[i]] += 1
  end
  counts[lst[-1]] += 1
  
  counts.each_value do |count|
    if count > 1
      return false
    end
  end
  
  return true
end