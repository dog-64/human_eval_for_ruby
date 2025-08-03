
def is_sorted?(lst)
  return true if lst.empty?

  prev = lst[0]
  count = 1

  (1...lst.length).each do |i|
    current = lst[i]
    
    if current < prev
      return false
    end
    
    if current == prev
      count += 1
    else
      count = 1
    end
    
    if count >= 3
      return false
    end
    
    prev = current
  end

  true
end