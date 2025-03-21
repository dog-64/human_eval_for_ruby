def will_it_fly?(q, w)
  return false if q.sum > w
  return true if q.empty?
  q == q.reverse
end