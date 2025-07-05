def is_sorted?(lst)
  return true if lst.empty?
  
  seen = {}
  for i in 0...lst.length - 1
    if lst[i] > lst[i+1]
      return false
    end
    
    if seen.key?(lst[i])
      return false
    else
      seen[lst[i]] = true
    end
  end
  
  if seen.key?(lst[-1])
    return false
  else
    seen[lst[-1]] = true
  end
  
  true
end
