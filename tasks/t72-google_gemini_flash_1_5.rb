def will_it_fly?(q, w)
  return true if q.empty?
  return false if q.sum > w
  q == q.reverse
end
