def is_sorted?(lst)
  return true if lst.empty?
  prev = lst.first
  lst.each do |x|
    return false if x == prev
    prev = x
  end
  true
end