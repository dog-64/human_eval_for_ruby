def is_sorted?(lst)
  return true if lst.empty?
  sorted = true
  unique = {}
  lst.each do |num|
    if unique[num]
      sorted = false
      break
    else
      unique[num] = true
    end
  end
  sorted && unique.size == lst.size
end