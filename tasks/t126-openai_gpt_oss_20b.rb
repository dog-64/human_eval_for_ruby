def is_sorted?(lst)
  return true if lst.empty?
  prev = lst[0]
  count = 1
  (1...lst.size).each do |i|
    curr = lst[i]
    return false if curr < prev
    if curr == prev
      count += 1
      return false if count > 2
    else
      prev = curr
      count = 1
    end
  end
  true
end