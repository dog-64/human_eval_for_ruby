def will_it_fly?(q, w)
  balanced = q == q.reverse
  weight = q.sum
  balanced && weight <= w
end
