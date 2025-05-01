def will_it_fly?(q, w)
  q == q.reverse && q.sum <= w
end
