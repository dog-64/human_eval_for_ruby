def will_it_fly?(q, w)
  balanced = q == q.reverse
  weight_ok = q.sum <= w
  balanced && weight_ok
end