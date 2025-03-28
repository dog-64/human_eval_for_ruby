def is_sorted?(lst)
  return true if lst.empty?
  lst.each_cons(2) do |a, b|
    return false if a > b || lst.count(a) > 1 || lst.count(b) > 1
  end
  true
end