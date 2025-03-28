def will_it_fly?(q, w)
  balanced = q == q.reverse
  total_weight = q.reduce(:+)
  balanced && total_weight <= w
end