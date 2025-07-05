def will_it_fly?(q, w)
  is_balanced = q == q.reverse
  total_weight = q.sum
  is_balanced && total_weight <= w
end
