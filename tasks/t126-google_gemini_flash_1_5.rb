def is_sorted?(lst)
  return true if lst.empty?
  
  counts = Hash.new(0)
  lst.each do |num|
    counts[num] += 1
    if counts[num] > 1
      return false
    end
  end

  (0...lst.length - 1).each do |i|
    if lst[i] >= lst[i+1]
      return false
    end
  end
  true
end
