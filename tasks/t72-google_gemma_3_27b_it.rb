def will_it_fly?(q, w)
  return false if q.nil? || w < 0
  sum = q.sum
  return false if sum > w
  q == q.reverse
end