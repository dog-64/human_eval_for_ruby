def will_it_fly?(q, w)
  balanced = q == q.reverse
  weight_within_limit = q.sum <= w
  balanced && weight_within_limit
end