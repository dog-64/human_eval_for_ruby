def will_it_fly?(q, w)
  return false if q.empty?
  return true if q == q.reverse
  return false if q.sum > w
end