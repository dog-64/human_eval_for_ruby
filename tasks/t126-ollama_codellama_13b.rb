def is_sorted?(lst)
  return true if lst.empty?
  sorted = true
  seen = Set.new
  lst.each do |x|
    if seen.include?(x)
      sorted = false
      break
    end
    seen << x
  end
  sorted && seen.size == lst.size
end